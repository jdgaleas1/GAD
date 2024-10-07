import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data'; // Para manejar bytes
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gad/Model/Dispositivos-PC-model.dart';
import 'package:gad/Model/Inventario-PC-model.dart';
import 'package:gad/Service/Dispositivos-PC-Servicio.dart';
import 'package:gad/Service/Inventario-PC-Servicio.dart';
import 'package:path_provider/path_provider.dart'; // Para obtener el directorio de descarga
import 'package:path/path.dart' as path; // Librería para manejar rutas
import 'package:flutter/foundation.dart' show kIsWeb; // Verifica si es web

// Importar la librería HTML solo si es web
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ImportarExportar {
  final InventarioService _inventarioService = InventarioService(); 
  final InventarioServiceDispositivos _inventarioServiceDispositivos = InventarioServiceDispositivos();

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

        // Procesar la primera hoja: PCs
        var sheetPC = excel.tables[excel.tables.keys.first]!.rows;
        for (var row in sheetPC.skip(1)) {
          if (_esFilaVacia(row)) {
            break;
          }
          InventarioPCs nuevaPC = InventarioPCs(
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
            dominio: row[16]?.value.toString() ?? '',
            programasLicencias: row[17]?.value.toString() ?? '',
            ipRestringidas: row[18]?.value.toString() ?? '',
            observaciones: row[19]?.value.toString() ?? '',
          );
          await _inventarioService.guardarInventario(nuevaPC);
        }

        // Procesar la segunda hoja: Dispositivos
        var sheetDispositivos = excel.tables[excel.tables.keys.elementAt(1)]!.rows;
        for (var row in sheetDispositivos.skip(1)) {
          if (_esFilaVacia(row)) {
            break;
          }
          Dispositivos nuevoDispositivo = Dispositivos(
            modelo: row[0]?.value.toString() ?? '',
            area: row[1]?.value.toString() ?? '',
            servicio: row[2]?.value.toString() ?? '',
            tipo: row[3]?.value.toString() ?? '',
            observaciones: row[4]?.value.toString() ?? '',
            marcaTemporal: row[5]?.value.toString() ?? '',
            ip: row[6]?.value.toString() ?? '',
          );
          await _inventarioServiceDispositivos.guardarInventario(nuevoDispositivo);
        }
      }
    }
  }

  Future<void> exportarDatosExcel() async {
    // Recuperar los datos de Firestore
    List<InventarioPCs> inventarioData = await _inventarioService.obtenerInventario();
    List<Dispositivos> dispositivosData = await _inventarioServiceDispositivos.obtenerInventario();

    // Crear un archivo Excel
    var excel = Excel.createExcel();

    // Primera hoja: Inventario de PCs
    Sheet sheetPC = excel['Inventario PCs'];
    sheetPC.appendRow([
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
      'ESTADO DE COMPUTADORA',
      'Dominio',
      'Programas y Licencias',
      'IP restringidas',
      'Observaciones'
    ]);

    // Llenar las filas con los datos del inventario de PCs
    for (var inventario in inventarioData) {
      sheetPC.appendRow([
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
        inventario.dominio ?? '',
        inventario.programasLicencias ?? '',
        inventario.ipRestringidas ?? '',
        inventario.observaciones ?? '',
      ]);
    }

    // Segunda hoja: Inventario de Dispositivos
    Sheet sheetDispositivos = excel['Inventario Dispositivos'];
    sheetDispositivos.appendRow([
      'Marca temporal',
      'IP',
      'Modelo',
      'Área',
      'Servicio',
      'Tipo',
      'Observaciones',
    ]);

    // Llenar las filas con los datos de los dispositivos
    for (var dispositivo in dispositivosData) {
      sheetDispositivos.appendRow([
        dispositivo.marcaTemporal ?? '',
        dispositivo.ip ?? '',
        dispositivo.modelo ?? '',
        dispositivo.area ?? '',
        dispositivo.servicio ?? '',
        dispositivo.tipo ?? '',
        dispositivo.observaciones ?? '',
      ]);
    }

    if (kIsWeb) {
      // Para web: Crear un blob y descargar el archivo
      final excelBytes = excel.encode();
      final blob = html.Blob([excelBytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'InventarioPCsYDispositivos.xlsx')
        ..click();
      html.Url.revokeObjectUrl(url); // Liberar memoria
    } else {
      // Para móviles y escritorio
      Directory? downloadsDirectory;
      if (io.Platform.isAndroid || io.Platform.isIOS) {
        downloadsDirectory = await getExternalStorageDirectory();
      } else if (io.Platform.isWindows || io.Platform.isLinux || io.Platform.isMacOS) {
        downloadsDirectory = await getDownloadsDirectory();
      }

      if (downloadsDirectory != null) {
        String filePath = path.join(downloadsDirectory.path, 'InventarioPCsYDispositivos.xlsx');

        // Guardar el archivo Excel
        io.File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(excel.encode()!);

        print('Archivo Excel exportado: $filePath');
      } else {
        print('No se pudo obtener el directorio de Descargas.');
      }
    }
  }
}
