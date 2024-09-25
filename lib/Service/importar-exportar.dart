import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gad/Model/Inventario-PC-model.dart';
import 'package:gad/Service/Inventario-PC-Servicio.dart';
import 'package:path_provider/path_provider.dart'; // Para obtener el directorio de descarga
import 'package:permission_handler/permission_handler.dart';

class ImportarExportar {
  final InventarioService _inventarioService =
      InventarioService(); // Instancia del servicio

  // Función para verificar si todas las celdas de una fila están vacías
  bool _esFilaVacia(List<Data?> row) {
    for (var cell in row) {
      if (cell != null &&
          cell.value != null &&
          cell.value.toString().trim().isNotEmpty) {
        return false;
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
        var sheet = excel.tables[excel.tables.keys.first]!.rows;

        for (var row in sheet.skip(1)) {
          // Saltar la primera fila que podría ser encabezado
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
      }
    }
  }

  Future<void> exportarDatosExcel() async {
    // Recuperar los datos de Firestore
    List<InventarioPCs> inventarioData =
        await _inventarioService.obtenerInventario();

    // Crear un archivo Excel
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Añadir la primera fila con los títulos de las columnas
    sheetObject.appendRow([
      "#",
      'Marca temporal',
      'Unidad',
      'IP',
      'NOMBRE DE LA PC',
      'NOMBRE DEL FUNCIONARIO',
      'PUESTO QUE OCUPA',
      'RED CONECTADA',
      'NOMBRE DE RED',
      'DNS-1',
      'DNS-2',
      'SISTEMA OPERATIVO',
      'MAQUINA TODO EN UNO',
      'CARACTERISTICAS',
      'LAPTOP',
      'CODIGO ACT FIJOS',
      'ESTADO DE COMPUTADORA'
    ]);

    // Llenar las filas con los datos del inventario
    for (var inventario in inventarioData) {
      sheetObject.appendRow([
        inventario.idPc ?? '',
        inventario.marcaTemporal ?? '',
        inventario.unidad ?? '',
        inventario.ip ?? '',
        inventario.nombreDeLaPc ?? '',
        inventario.nombreDelFuncionario ?? '',
        inventario.puestoQueOcupa ?? '',
        inventario.redConectada ?? '',
        inventario.nombreDeRed ?? '',
        inventario.dns1 ?? '',
        inventario.dns2 ?? '',
        inventario.sistemaOperativo ?? '',
        inventario.maquinaTodoEnUno ?? '',
        inventario.caracteristicas ?? '',
        inventario.laptop ?? '',
        inventario.codigoActFijos ?? '',
        inventario.estadoDeComputadora ?? '',
      ]);
    }

    // Obtener el directorio de Descargas
    Directory? downloadsDirectory =
        await getExternalStorageDirectory(); // Cambiado a un directorio accesible

    if (downloadsDirectory != null) {
      String filePath = '${downloadsDirectory.path}/InventarioPCs.xlsx';

      // Guardar el archivo Excel
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);

      print('Archivo Excel exportado: $filePath');
    } else {
      print('No se pudo obtener el directorio de Descargas.');
    }
  }
}