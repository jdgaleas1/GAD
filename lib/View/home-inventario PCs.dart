import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:gad/Model/Inventario-PC-model.dart';
import 'package:gad/Service/Inventario-PC-Servicio.dart';
import 'package:gad/View/Inventario-PCS.dart';

class PCsHome extends StatefulWidget {
  const PCsHome({super.key});

  @override
  State<PCsHome> createState() => _PCsHomeState();
}

class _PCsHomeState extends State<PCsHome> {
  final InventarioService _inventarioService = InventarioService(); // Instancia del servicio

  Future<void> _refreshAutos() async {
    setState(() {});
  }

  // Función para verificar si todas las celdas de una fila están vacías
  bool _esFilaVacia(List<Data?> row) {
    // Recorremos todas las celdas de la fila y verificamos si están vacías o nulas
    for (var cell in row) {
      if (cell != null && cell.value != null && cell.value.toString().trim().isNotEmpty) {
        return false; // Si alguna celda tiene un valor, no está vacía
      }
    }
    return true; // Todas las celdas están vacías
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

        // Asumimos que los datos están en la primera hoja y en un formato específico
        var sheet = excel.tables[excel.tables.keys.first]!.rows;

        // Iterar sobre las filas del Excel y procesar los datos
        for (var row in sheet.skip(1)) { // Saltar la primera fila que podría ser encabezado
          
          // Verificar si la fila está vacía, y si lo está, se salta
          if (_esFilaVacia(row)) {
            break; // Detiene el bucle si encuentra una fila completamente vacía
          }

          // Procesar la fila si no está vacía
          InventarioPCs nuevaPC = InventarioPCs(
            idPc: '', // El ID se generará automáticamente
            marcaTemporal: row[0]?.value.toString() ?? '',
            unidad: row[1]?.value.toString() ?? '',
            ip: row[2]?.value.toString() ?? '',
            nombreDeLaPc: row[3]?.value.toString() ?? '',
            nombreDelFuncionario: row[4]?.value.toString() ?? '',
            puestoQueOcupa: row[5]?.value.toString() ?? '',
            redConectada: row[6]?.value.toString() ?? '',
            nombreDeRed: row[7]?.value.toString() ?? '',
            dns1: row[8]?.value.toString() ?? '',
            dns2: row[9]?.value.toString() ?? '',
            sistemaOperativo: row[10]?.value.toString() ?? '',
            maquinaTodoEnUno: row[11]?.value.toString() ?? '',
            caracteristicas: row[12]?.value.toString() ?? '',
            laptop: row[13]?.value.toString() ?? '',
            codigoActFijos: row[14]?.value.toString() ?? '',
            estadoDeComputadora: row[15]?.value.toString() ?? '',
          );

          // Guardar cada fila en Firestore
          await _inventarioService.guardarInventario(nuevaPC);
        }

        // Mostrar un mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos del Excel subidos exitosamente')),
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
