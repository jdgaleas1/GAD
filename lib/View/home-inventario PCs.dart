import 'package:flutter/material.dart';
import 'package:gad/View/Inventario-PCS.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:gad/Service/Inventario-PC-Servicio.dart'; // Servicio para acceder a Firestore
import 'package:gad/Model/Inventario-PC-model.dart'; // Modelo InventarioPCs

class PCsHome extends StatefulWidget {
  const PCsHome({super.key});

  @override
  State<PCsHome> createState() => _PCsHomeState();
}

class _PCsHomeState extends State<PCsHome> {
  final InventarioService _firestoreService =
      InventarioService(); // Instancia de tu servicio

  Future<void> _refreshInventario() async {
    setState(() {}); // Actualiza la vista
  }

  Future<void> seleccionarArchivoExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      var bytes = result.files.single.bytes;
      if (bytes != null) {
        var excel = Excel.decodeBytes(bytes);
        var sheet = excel.tables[excel.tables.keys.first]!.rows;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos subidos exitosamente')),
        );

        _refreshInventario(); // Refresca el inventario después de subir el Excel
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario PCs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_upload),
            onPressed: seleccionarArchivoExcel,
          ),
        ],
      ),
      body: FutureBuilder<List<InventarioPCs>>(
        future: _firestoreService
            .obtenerInventario(), // Llama a la función que obtiene los datos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(), // Muestra un indicador de carga
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                  'Error al cargar los datos'), // Muestra un mensaje de error
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                  'No hay datos disponibles'), // Muestra un mensaje si no hay datos
            );
          } else {
            var inventarios = snapshot.data!; // Obtiene la lista de inventarios
            return ListView.builder(
              itemCount: inventarios.length,
              itemBuilder: (context, index) {
                var pc = inventarios[index];
                return ListTile(
                  title: Text(pc.nombreDeLaPc ??
                      'Sin nombre'), // Muestra el nombre de la PC
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${pc.idPc ?? 'N/A'}'),
                      Text('Marca Temporal: ${pc.marcaTemporal}'),
                      Text('Unidad: ${pc.unidad}'),
                      Text('IP: ${pc.ip ?? 'N/A'}'),
                      Text(
                          'Nombre del Funcionario: ${pc.nombreDelFuncionario ?? 'N/A'}'),
                      Text('Puesto que Ocupa: ${pc.puestoQueOcupa ?? 'N/A'}'),
                      Text('Red Conectada: ${pc.redConectada ?? 'N/A'}'),
                      Text('Nombre de Red: ${pc.nombreDeRed ?? 'N/A'}'),
                      Text('DNS 1: ${pc.dns1 ?? 'N/A'}'),
                      Text('DNS 2: ${pc.dns2 ?? 'N/A'}'),
                      Text(
                          'Sistema Operativo: ${pc.sistemaOperativo ?? 'N/A'}'),
                      Text(
                          'Maquina Todo en Uno: ${pc.maquinaTodoEnUno ?? 'N/A'}'),
                      Text('Características: ${pc.caracteristicas ?? 'N/A'}'),
                      Text('Laptop: ${pc.laptop ?? 'N/A'}'),
                      Text(
                          'Código Activos Fijos: ${pc.codigoActFijos ?? 'N/A'}'),
                      Text(
                          'Estado de la Computadora: ${pc.estadoDeComputadora ?? 'N/A'}'),
                    ],
                  ),
                  onTap: () {
                    // Puedes agregar una acción al tocar el elemento
                  },
                );
              },
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
            _refreshInventario(); // Refresca los datos al agregar un nuevo PC
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
