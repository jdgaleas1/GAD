import 'package:flutter/material.dart';
import 'package:gad/View/Inventario-PCS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';

class PCsHome extends StatefulWidget {
  const PCsHome({super.key});

  @override
  State<PCsHome> createState() => _PCsHomeState();
}

class _PCsHomeState extends State<PCsHome> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _refreshAutos() async {
    setState(() {});
  }

  Future<void> seleccionarArchivoExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      // Leer el archivo Excel
      var bytes = result.files.single.bytes;
      if (bytes != null) {
        var excel = Excel.decodeBytes(bytes);

        // Asumimos que los datos están en la primera hoja y en un formato específico
        var sheet = excel.tables[excel.tables.keys.first]!.rows;

        // Iterar sobre las filas del Excel
        for (var row in sheet) {
          if (row.isNotEmpty) {
            await _firestore.collection('pcs').add({
              'marca_temporal': row[0]?.value,
              'unidad': row[1]?.value,
              'ip': row[2]?.value,
              'nombre_pc': row[3]?.value,
              'nombre_funcionario': row[4]?.value,
              'puesto_ocupa': row[5]?.value,
              'red_conectada': row[6]?.value,
              'nombre_red': row[7]?.value,
              'dns1': row[8]?.value,
              'dns2': row[9]?.value,
              'sistema_operativo': row[10]?.value,
              'maquinas_todo_en_uno': row[11]?.value,
              'caracteristicas_pcs': row[12]?.value,
              'laptop': row[13]?.value,
              'codigo_act_fijos': row[14]?.value,
              'estado_computadora': row[15]?.value,
            });
          }
        }

        // Mostrar un mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos subidos exitosamente')),
        );

        // Refrescar la vista después de agregar los datos
        _refreshAutos();
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
            onPressed: seleccionarArchivoExcel, // Opción para subir Excel
          ),
        ],
      ),
      body: Center(
        child: const Text('Aquí puedes ver el inventario de PCs'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Funcionalidad existente para agregar un nuevo PC
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AgregarPCs()), // Asegúrate de que esta clase esté definida
          );
          if (result == true) {
            _refreshAutos();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
