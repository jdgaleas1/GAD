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
      body: FutureBuilder<List<InventarioPCs>>(
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
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
