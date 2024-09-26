import 'dart:async'; // Importa el paquete de temporizador
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
  List<InventarioPCs> _inventariosFiltrados = [];
  final InventarioService _inventarioService = InventarioService();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce; // Variable para manejar el temporizador de debounce

  @override
  void initState() {
    super.initState();
    _futureInventarios = _inventarioService.obtenerInventario();
    _searchController.addListener(_onSearchChanged);
  }

  // Cuando el texto cambia, reseteamos el temporizador
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Solo iniciar la búsqueda cuando haya al menos 3 caracteres
    if (_searchController.text.length >= 4) {
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _filterInventarios();
      });
    } else {
      // Limpiar los resultados si hay menos de 3 caracteres
      setState(() {
        _inventariosFiltrados.clear();
      });
    }
  }

  // Función para filtrar los resultados basados en el valor del campo de búsqueda
  void _filterInventarios() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _futureInventarios!.then((inventarios) {
        _inventariosFiltrados = inventarios.where((pc) {
          return pc.nombreDeLaPc!.toLowerCase().contains(query) ||
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
    _debounce?.cancel(); // Cancelar el temporizador al destruir el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario PCs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: _refreshPCs,
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
                        DataCell(Text(pc.idPc ?? 'N/A')), DataCell(Text(pc.marcaTemporal)), DataCell(Text(pc.unidad)),
                        DataCell(Text(pc.nombreDeLaPc ?? 'Sin nombre')), DataCell(Text(pc.nombreDelFuncionario ?? 'N/A')),
                        DataCell(Text(pc.puestoQueOcupa ?? 'N/A')), DataCell(Text(pc.ip ?? 'N/A')), DataCell(Text(pc.redConectada ?? 'N/A')),
                        DataCell(Text(pc.nombreDeRed ?? 'N/A')), DataCell(Text(pc.dns1 ?? 'N/A')), DataCell(Text(pc.dns2 ?? 'N/A')),
                        DataCell(Text(pc.sistemaOperativo ?? 'N/A')), DataCell(Text(pc.maquinaTodoEnUno ?? 'N/A')), DataCell(Text(pc.caracteristicas ?? 'N/A')),
                        DataCell(Text(pc.laptop ?? 'N/A')), DataCell(Text(pc.codigoActFijos ?? 'N/A')), DataCell(Text(pc.estadoDeComputadora ?? 'N/A')),
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
