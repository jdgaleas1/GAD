import 'dart:async';
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
      body: FutureBuilder<List<InventarioDispositivos>>(
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
                DataColumn(label: Text('Modelo')),
                DataColumn(label: Text('Área')),
                DataColumn(label: Text('Servicio')),
                DataColumn(label: Text('Tipo')),
                DataColumn(label: Text('Observaciones')),
                DataColumn(label: Text('Marca Temporal')),
                DataColumn(label: Text('IP')),
                DataColumn(label: Text('Acciones')), // Columna para acciones
              ],
              rows: snapshot.data!.map((inventario) {
                return DataRow(cells: [
                  DataCell(Text(inventario.modelo)),
                  DataCell(Text(inventario.area)),
                  DataCell(Text(inventario.servicio)),
                  DataCell(Text(inventario.tipo)),
                  DataCell(Text(inventario.observaciones)),
                  DataCell(Text(inventario.marcaTemporal)),
                  DataCell(Text(inventario.ip)),
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
  void _mostrarFormularioEditar(
      BuildContext context, InventarioDispositivos inventario) {
    // Abre una nueva página o muestra un formulario en un diálogo para editar los datos.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _modeloController =
            TextEditingController(text: inventario.modelo);
        final _areaController = TextEditingController(text: inventario.area);
        final _servicioController =
            TextEditingController(text: inventario.servicio);
        final _tipoController = TextEditingController(text: inventario.tipo);
        final _observacionesController =
            TextEditingController(text: inventario.observaciones);
        final _marcaTemporalController =
            TextEditingController(text: inventario.marcaTemporal);
        final _ipController = TextEditingController(text: inventario.ip);

        return AlertDialog(
          title: Text('Editar Dispositivo'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _modeloController,
                  decoration: InputDecoration(labelText: 'Modelo'),
                ),
                TextField(
                  controller: _areaController,
                  decoration: InputDecoration(labelText: 'Área'),
                ),
                TextField(
                  controller: _servicioController,
                  decoration: InputDecoration(labelText: 'Servicio'),
                ),
                TextField(
                  controller: _tipoController,
                  decoration: InputDecoration(labelText: 'Tipo'),
                ),
                TextField(
                  controller: _observacionesController,
                  decoration: InputDecoration(labelText: 'Observaciones'),
                ),
                TextField(
                  controller: _marcaTemporalController,
                  decoration: InputDecoration(labelText: 'Marca Temporal'),
                ),
                TextField(
                  controller: _ipController,
                  decoration: InputDecoration(labelText: 'IP'),
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
                InventarioDispositivos actualizado = InventarioDispositivos(
                  modelo: _modeloController.text,
                  area: _areaController.text,
                  servicio: _servicioController.text,
                  tipo: _tipoController.text,
                  observaciones: _observacionesController.text,
                  marcaTemporal: _marcaTemporalController.text,
                  ip: _ipController.text,
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
  void _confirmarEliminar(
      BuildContext context, InventarioDispositivos inventario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content:
              Text('¿Estás seguro de que deseas eliminar este dispositivo?'),
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
                    .eliminarDispositivo(inventario.marcaTemporal!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
