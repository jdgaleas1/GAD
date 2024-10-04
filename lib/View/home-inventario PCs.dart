import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gad/Service/Inventario-PC-Servicio.dart';
import 'package:gad/Model/Inventario-PC-model.dart';

class PCsHome extends StatefulWidget {
  const PCsHome({super.key});

  @override
  State<PCsHome> createState() => _PCsHomeState();
}

class _PCsHomeState extends State<PCsHome> {
  Future<List<InventarioPCs>>? _futureInventarios;
  List<InventarioPCs> _inventariosFiltrados = [];
  final InventarioService _inventarioService = InventarioService();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<String> _editingRows = [];

  // Función para formatear la dirección IP
  String _formatIP(String? ip) {
    if (ip == null || ip.isEmpty) return '000.000.000.000';
    return ip.split('.').map((octeto) {
      return octeto.padLeft(3, '0');
    }).join('.');
  }

  @override
  void initState() {
    super.initState();
    _futureInventarios = _inventarioService.obtenerInventario();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    if (_searchController.text.length >= 4) {
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _filterInventarios();
      });
    } else {
      setState(() {
        _inventariosFiltrados.clear();
      });
    }
  }

  void _filterInventarios() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _futureInventarios!.then((inventarios) {
        _inventariosFiltrados = inventarios.where((pc) {
          return pc.codigoActFijos!.toLowerCase().contains(query) ||
              pc.ip!.toLowerCase().contains(query) ||
              pc.nombreDelFuncionario!.toLowerCase().contains(query);
        }).toList();
      });
    });
  }

  Future<void> _refreshPCs() async {
    setState(() {
      _futureInventarios = _inventarioService.obtenerInventario();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar por Codigo, IP, o Funcionario',
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'refrescar') {
                _refreshPCs();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'refrescar',
                child: ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('Refrescar lista'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<InventarioPCs>>(
        future: _futureInventarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          } else {
            var inventarios = _inventariosFiltrados.isNotEmpty
                ? _inventariosFiltrados
                : snapshot.data!;
            inventarios.sort((a, b) {
              String ipA = _formatIP(a.ip);
              String ipB = _formatIP(b.ip);
              return ipA.compareTo(ipB);
            });

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  dataRowHeight: 160,
                  columns: const [
                    DataColumn(label: Text('Marca Temporal')),
                    DataColumn(label: Text('Unidad')),
                    DataColumn(label: Text('Nombre de la PC')),
                    DataColumn(label: Text('Funcionario')),
                    DataColumn(label: Text('Puesto')),
                    DataColumn(label: Text('IP')),
                    DataColumn(label: Text('Red Conectada')),
                    DataColumn(label: Text('Nombre de la Red')),
                    DataColumn(label: Text('DNS 1')),
                    DataColumn(label: Text('DNS 2')),
                    DataColumn(label: Text('Sistema Operativo')),
                    DataColumn(label: Text('Maquina todo en uno')),
                    DataColumn(label: Text('Características PC')),
                    DataColumn(label: Text('Laptop')),
                    DataColumn(label: Text('Codigo ACT Fijos')),
                    DataColumn(label: Text('Estado de la Computadora')),
                    DataColumn(label: Text('Dominio')),
                    DataColumn(label: Text('Programas y Licencias')),
                    DataColumn(label: Text('IP Restringidas')),
                    DataColumn(label: Text('Observaciones')),
                    DataColumn(label: Text('Editar')),
                    DataColumn(label: Text('Eliminar')),

                  ],
                  rows: inventarios.map((pc) {
                    bool isEditing = _editingRows.contains(pc.marcaTemporal);

                    return DataRow(
                      cells: [
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.marcaTemporal,
                                onChanged: (value) {
                                  pc.marcaTemporal = value;
                                },
                              )
                            : Text(pc.marcaTemporal)),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.unidad,
                                onChanged: (value) {
                                  pc.unidad = value;
                                },
                              )
                            : Text(pc.unidad)),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.nombreDeLaPc ?? 'Sin nombre',
                                onChanged: (value) {
                                  pc.nombreDeLaPc = value;
                                },
                              )
                            : Text(pc.nombreDeLaPc ?? 'Sin nombre')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.nombreDelFuncionario ?? 'N/A',
                                onChanged: (value) {
                                  pc.nombreDelFuncionario = value;
                                },
                              )
                            : Text(pc.nombreDelFuncionario ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.puestoQueOcupa ?? 'N/A',
                                onChanged: (value) {
                                  pc.puestoQueOcupa = value;
                                },
                              )
                            : Text(pc.puestoQueOcupa ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.ip ?? 'N/A',
                                onChanged: (value) {
                                  pc.ip = value;
                                },
                              )
                            : Text(pc.ip ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.redConectada ?? 'N/A',
                                onChanged: (value) {
                                  pc.redConectada = value;
                                },
                              )
                            : Text(pc.redConectada ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.nombreDeRed ?? 'N/A',
                                onChanged: (value) {
                                  pc.nombreDeRed = value;
                                },
                              )
                            : Text(pc.nombreDeRed ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.dns1 ?? 'N/A',
                                onChanged: (value) {
                                  pc.dns1 = value;
                                },
                              )
                            : Text(pc.dns1 ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.dns2 ?? 'N/A',
                                onChanged: (value) {
                                  pc.dns2 = value;
                                },
                              )
                            : Text(pc.dns2 ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.sistemaOperativo ?? 'N/A',
                                onChanged: (value) {
                                  pc.sistemaOperativo = value;
                                },
                              )
                            : Text(pc.sistemaOperativo ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.maquinaTodoEnUno ?? 'N/A',
                                onChanged: (value) {
                                  pc.maquinaTodoEnUno = value;
                                },
                              )
                            : Text(pc.maquinaTodoEnUno ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.caracteristicas ?? 'N/A',
                                onChanged: (value) {
                                  pc.caracteristicas = value;
                                },
                              )
                            : Text(pc.caracteristicas ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.laptop ?? 'N/A',
                                onChanged: (value) {
                                  pc.laptop = value;
                                },
                              )
                            : Text(pc.laptop ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.codigoActFijos ?? 'N/A',
                                onChanged: (value) {
                                  pc.codigoActFijos = value;
                                },
                              )
                            : Text(pc.codigoActFijos ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.estadoDeComputadora ?? 'N/A',
                                onChanged: (value) {
                                  pc.estadoDeComputadora = value;
                                },
                              )
                            : Text(pc.estadoDeComputadora ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(initialValue: pc.dominio ?? 'N/A')
                            : Text(pc.dominio ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.programasLicencias ?? 'N/A',
                                onChanged: (value) {
                                  pc.programasLicencias = value;
                                },
                              )
                            : Text(pc.programasLicencias ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.ipRestringidas ?? 'N/A',
                                onChanged: (value) {
                                  pc.ipRestringidas = value;
                                },
                              )
                            : Text(pc.ipRestringidas ?? 'N/A')),
                        DataCell(isEditing
                            ? TextFormField(
                                initialValue: pc.observaciones ?? 'N/A',
                                onChanged: (value) {
                                  pc.observaciones = value;
                                },
                              )
                            : Text(pc.observaciones ?? 'N/A')),
                        DataCell(
                          IconButton(
                            icon: isEditing
                                ? const Icon(Icons.save)
                                : const Icon(Icons.edit),
                            onPressed: () async {
                              setState(() {
                                if (isEditing) {
                                  // Actualiza el inventario en Firestore
                                  _inventarioService.actualizarInventario(pc);
                                  _editingRows.remove(pc.marcaTemporal);
                                } else {
                                  _editingRows.add(pc.marcaTemporal!);
                                }
                              });
                            },
                          ),
                        ),
                        DataCell(
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Confirmar eliminación"),
                                        content: Text("¿Estás seguro de que deseas eliminar este PC?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Cerrar el diálogo
                                            },
                                            child: Text("Cancelar"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _inventarioService.eliminarPC(pc.marcaTemporal!);
                                              _refreshPCs(); // Refrescar la lista después de eliminar
                                              Navigator.of(context).pop(); // Cerrar el diálogo
                                            },
                                            child: Text("Eliminar"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),



                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}