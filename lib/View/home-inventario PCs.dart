import 'package:flutter/material.dart';
import 'package:gad/View/Inventario-PCS.dart';
import 'package:gad/Service/Inventario-PC-Servicio.dart'; // Servicio para acceder a Firestore
import 'package:gad/Model/Inventario-PC-model.dart'; // Modelo InventarioPCs

class PCsHome extends StatefulWidget {
  const PCsHome({super.key});

  @override
  State<PCsHome> createState() => _PCsHomeState();
}
class _PCsHomeState extends State<PCsHome> {
  Future<List<InventarioPCs>>? _futureInventarios; // Variable para almacenar el Future

  @override
  void initState() {
    super.initState();
    _futureInventarios = _inventarioService.obtenerInventario(); // Cargar datos al iniciar
  }

  Future<void> _refreshPCs() async {
    setState(() {
      _futureInventarios = _inventarioService.obtenerInventario(); // Refrescar los datos
    });
  }

  final InventarioService _inventarioService = InventarioService(); // Instancia del servicio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario PCs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: _refreshPCs, // Correcta referencia a la función
          ),
        ],
      ),
      body: FutureBuilder<List<InventarioPCs>>(
        future: _futureInventarios, // Usar el Future almacenado
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Muestra un indicador de carga
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar los datos'), // Muestra un mensaje de error
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay datos disponibles'), // Muestra un mensaje si no hay datos
            );
          } else {
            var inventarios = snapshot.data!; // Obtiene la lista de inventarios
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre de la PC')),
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Marca Temporal')),
                  DataColumn(label: Text('Unidad')),
                  DataColumn(label: Text('IP')),
                  DataColumn(label: Text('Funcionario')),
                  DataColumn(label: Text('Puesto')),
                  DataColumn(label: Text('Estado')),
                ],
                rows: inventarios.map((pc) {
                  return DataRow(
                    cells: [
                      DataCell(Text(pc.nombreDeLaPc ?? 'Sin nombre')),
                      DataCell(Text(pc.idPc ?? 'N/A')),
                      DataCell(Text(pc.marcaTemporal)),
                      DataCell(Text(pc.unidad)),
                      DataCell(Text(pc.ip ?? 'N/A')),
                      DataCell(Text(pc.nombreDelFuncionario ?? 'N/A')),
                      DataCell(Text(pc.puestoQueOcupa ?? 'N/A')),
                      DataCell(Text(pc.estadoDeComputadora ?? 'N/A')),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgregarPCs(),
            ),
          );
          if (result == true) {
            _refreshPCs(); // Refrescar datos después de agregar una PC
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
