import 'package:flutter/material.dart';
import 'package:gad/Service/Dispositivos-PC-Servicio.dart';
import 'package:gad/Model/Dispositivos-PC-model.dart';

class InventarioTabla extends StatelessWidget {
  final InventarioServiceDispositivos _inventarioService =
      InventarioServiceDispositivos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario de Dispositivos'),
      ),
      body: FutureBuilder<List<Dispositivos>>(
        future: _inventarioService.obtenerInventario(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los datos'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay inventario disponible.'));
          }

          // Si hay datos, los mostramos en una tabla
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Marca Temporal')),
                DataColumn(label: Text('IP')),
                DataColumn(label: Text('Modelo')),
                DataColumn(label: Text('Área')),
                DataColumn(label: Text('Servicio')),
                DataColumn(label: Text('Tipo')),
                DataColumn(label: Text('Encargado')),
                DataColumn(label: Text('Codigo Act Fijos Dispositivos')),
                DataColumn(label: Text('Observaciones')),
                DataColumn(label: Text('Custodio')),
                DataColumn(label: Text('Acciones')), // Columna para acciones
              ],
              rows: snapshot.data!.map((inventario) {
                return DataRow(cells: [
                  DataCell(Text(inventario.marcaTemporal)),
                  DataCell(Text(inventario.ip)),
                  DataCell(Text(inventario.modelo)),
                  DataCell(Text(inventario.area)),
                  DataCell(Text(inventario.servicio)),
                  DataCell(Text(inventario.tipo)),
                  DataCell(Text(inventario.encargado)),
                  DataCell(Text(inventario.codigoActFijosDispositivos)),
                  DataCell(Text(inventario.observaciones)),
                  DataCell(Text(inventario.custodio)),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _mostrarFormularioEditar(context, inventario);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _confirmarEliminar(context, inventario);
                          },
                        ),
                      ],
                    ),
                  ),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  // Función para mostrar el formulario de edición
  void _mostrarFormularioEditar(BuildContext context, Dispositivos inventario) {
    // Abre una nueva página o muestra un formulario en un diálogo para editar los datos.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final marcaTemporalController =
            TextEditingController(text: inventario.marcaTemporal);
        final ipController = TextEditingController(text: inventario.ip);
        final modeloController = TextEditingController(text: inventario.modelo);
        final areaController = TextEditingController(text: inventario.area);
        final servicioController =
            TextEditingController(text: inventario.servicio);
        final tipoController = TextEditingController(text: inventario.tipo);
        final encargadoController =
            TextEditingController(text: inventario.encargado);
        final codigoActFijosDispositivosController =
            TextEditingController(text: inventario.codigoActFijosDispositivos);
        final observacionesController =
            TextEditingController(text: inventario.observaciones);
        final custodioController =
            TextEditingController(text: inventario.custodio);

        return AlertDialog(
          title: Text('Editar Dispositivo'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: marcaTemporalController,
                  decoration:
                      InputDecoration(labelText: 'Marca Temporal'),
                ),
                TextField(
                  controller: ipController,
                  decoration: InputDecoration(labelText: 'IP'),
                ),
                TextField(
                  controller: modeloController,
                  decoration: InputDecoration(labelText: 'Modelo'),
                ),
                TextField(
                  controller: areaController,
                  decoration: InputDecoration(labelText: 'Área'),
                ),
                TextField(
                  controller: servicioController,
                  decoration: InputDecoration(labelText: 'Servicio'),
                ),
                TextField(
                  controller: tipoController,
                  decoration: InputDecoration(labelText: 'Tipo'),
                ),
                TextField(
                  controller: encargadoController,
                  decoration: InputDecoration(labelText: 'Encargado'),
                ),
                TextField(
                  controller: codigoActFijosDispositivosController,
                  decoration:
                      InputDecoration(labelText: 'Codigo Act Fijos'),
                ),
                TextField(
                  controller: observacionesController,
                  decoration: InputDecoration(labelText: 'Observaciones'),
                ),
                TextField(
                  controller: custodioController,
                  decoration: InputDecoration(labelText: 'Custodio'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () async {
                // Actualizar el dispositivo en la base de datos
                Dispositivos actualizado = Dispositivos(
                  marcaTemporal: marcaTemporalController.text,
                  ip: ipController.text,
                  modelo: modeloController.text,
                  area: areaController.text,
                  servicio: servicioController.text,
                  tipo: tipoController.text,
                  encargado: encargadoController.text,
                  codigoActFijosDispositivos:
                      codigoActFijosDispositivosController.text,
                  observaciones: observacionesController.text,
                  custodio: custodioController.text,
                );
                await _inventarioService.actualizarDispositivo(actualizado);
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  // Función para confirmar y eliminar el dispositivo
  void _confirmarEliminar(BuildContext context, Dispositivos inventario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text(
              '¿Estás seguro de que deseas eliminar este dispositivo?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () async {
                await _inventarioService
                    .eliminarDispositivo(inventario.marcaTemporal);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
