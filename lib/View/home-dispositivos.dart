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
        title: const Text('Inventario de Dispositivos'),
      ),
      body: FutureBuilder<List<Dispositivos>>(
        future: _inventarioService.obtenerInventario(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay inventario disponible.'));
          }

          // Si hay datos, los mostramos en una tabla
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Marca Temporal')),
                DataColumn(label: Text('IP')),
                DataColumn(label: Text('Modelo')),
                DataColumn(label: Text('Área')),
                DataColumn(label: Text('Servicio')),
                DataColumn(label: Text('Tipo')),
                DataColumn(label: Text('Observaciones')),
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
                  DataCell(Text(inventario.observaciones)),

                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _mostrarFormularioEditar(context, inventario);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
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
      BuildContext context, Dispositivos inventario) {
    // Abre una nueva página o muestra un formulario en un diálogo para editar los datos.
    showDialog(
      context: context,
      builder: (BuildContext context) {
                final marcaTemporalController =
            TextEditingController(text: inventario.marcaTemporal);
        final ipController = TextEditingController(text: inventario.ip);
        final modeloController =
            TextEditingController(text: inventario.modelo);
        final areaController = TextEditingController(text: inventario.area);
        final servicioController =
            TextEditingController(text: inventario.servicio);
        final tipoController = TextEditingController(text: inventario.tipo);
        final observacionesController =
            TextEditingController(text: inventario.observaciones);


        return AlertDialog(
          title: const Text('Editar Dispositivo'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: marcaTemporalController,
                  decoration: const InputDecoration(labelText: 'Marca Temporal'),
                ),
                TextField(
                  controller: ipController,
                  decoration: const InputDecoration(labelText: 'IP'),
                ),
                TextField(
                  controller: modeloController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                ),
                TextField(
                  controller: areaController,
                  decoration: const InputDecoration(labelText: 'Área'),
                ),
                TextField(
                  controller: servicioController,
                  decoration: const InputDecoration(labelText: 'Servicio'),
                ),
                TextField(
                  controller: tipoController,
                  decoration: const InputDecoration(labelText: 'Tipo'),
                ),
                TextField(
                  controller: observacionesController,
                  decoration: const InputDecoration(labelText: 'Observaciones'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () async {
                // Actualizar el dispositivo en la base de datos
                Dispositivos actualizado = Dispositivos(
                  marcaTemporal: marcaTemporalController.text,
                  ip: ipController.text,
                  modelo: modeloController.text,
                  area: areaController.text,
                  servicio: servicioController.text,
                  tipo: tipoController.text,
                  observaciones: observacionesController.text,

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
      BuildContext context, Dispositivos inventario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content:
              const Text('¿Estás seguro de que deseas eliminar este dispositivo?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
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
