import 'package:flutter/material.dart';
import 'package:gad/View/Inventario-PCS.dart';
import 'package:gad/Service/Inventario-PC-Servicio.dart';
import 'package:gad/Model/Inventario-PC-model.dart';

class PCsHome extends StatefulWidget {
  const PCsHome({super.key});
  @override
  State<PCsHome> createState() => _PCsHomeState();
}
class _PCsHomeState extends State<PCsHome> {
  Future<List<InventarioPCs>>? _futureInventarios;
  bool _isEditActive = false; // Variable para el Switch de edición
  bool _isMarkingActive = false; // Variable para el Switch de señalar filas
  List<InventarioPCs> _inventariosFiltrados = [];
  final InventarioService _inventarioService = InventarioService();
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _futureInventarios = _inventarioService.obtenerInventario();
    _searchController.addListener(_filterInventarios);
  }
  Future<void> _refreshPCs() async {
    setState(() {
      _futureInventarios = _inventarioService.obtenerInventario();
    });
  }
  // Función para filtrar los resultados basados en el valor del campo de búsqueda
  void _filterInventarios() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _inventariosFiltrados = [];
      } else {
        _futureInventarios!.then((inventarios) {
          _inventariosFiltrados = inventarios.where((pc) {
            return pc.nombreDeLaPc!.toLowerCase().contains(query) ||
                pc.ip!.toLowerCase().contains(query) ||
                pc.nombreDelFuncionario!.toLowerCase().contains(query);
          }).toList();
        });
      }
    });
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Inventario PCs'),
        ),
        actions: [
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
              PopupMenuItem<String>(
                // Opción para activar/desactivar la edición con un switch
                value: 'edicion',
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return ListTile(
                      leading: Icon(Icons.edit),
                      title: const Text('Edición activa'),
                      trailing: Switch(
                        value: _isEditActive,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isEditActive = newValue;
                          });
                          Navigator.pop(context); // Cerrar el menú después de cambiar
                        },
                      ),
                    );
                  },
                ),
              ),
              PopupMenuItem<String>(
                // Opción para activar/desactivar el marcado de filas con un switch
                value: 'señalar',
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return ListTile(
                      leading: Icon(Icons.drive_file_rename_outline),
                      title: const Text('Señalar filas'),
                      trailing: Switch(
                        value: _isMarkingActive,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isMarkingActive = newValue;
                          });
                          Navigator.pop(context); // Cerrar el menú después de cambiar
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por nombre de PC, IP, o Funcionario',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
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

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')), DataColumn(label: Text('Marca Temporal')),DataColumn(label: Text('Unidad')),
                    DataColumn(label: Text('Nombre de la PC')), DataColumn(label: Text('Funcionario')), DataColumn(label: Text('Puesto')),
                    DataColumn(label: Text('IP')), DataColumn(label: Text('Red Conectada')), DataColumn(label: Text('Nombre de la Red')),
                    DataColumn(label: Text('DNS 1')), DataColumn(label: Text('DNS 2')), DataColumn(label: Text('Sistema Operativo')),
                    DataColumn(label: Text('Maquina todo en uno')), DataColumn(label: Text('Características PC')),
                    DataColumn(label: Text('Laptop')), DataColumn(label: Text('Codigo ACT Fijos')), DataColumn(label: Text('Estado de la Computadora')),
                  ],
                  rows: inventarios.map((pc) {
                    return DataRow(
                      cells: [
                        DataCell(Text(pc.idPc)), DataCell(Text(pc.marcaTemporal)), DataCell(Text(pc.unidad)),
                        DataCell(Text(pc.nombreDeLaPc)), DataCell(Text(pc.nombreDelFuncionario)),DataCell(Text(pc.puestoQueOcupa)),
                        DataCell(Text(pc.ip)), DataCell(Text(pc.redConectada)), DataCell(Text(pc.nombreDeRed)), DataCell(Text(pc.dns1)),
                        DataCell(Text(pc.dns2)), DataCell(Text(pc.sistemaOperativo)), DataCell(Text(pc.maquinaTodoEnUno)),
                        DataCell(Text(pc.caracteristicas)),  DataCell(Text(pc.laptop)),  DataCell(Text(pc.codigoActFijos)),
                        DataCell(Text(pc.estadoDeComputadora)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgregarPCs()),
          );
          if (result == true) {
            _refreshPCs();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
