import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gad/Model/Dispositivos-PC-model.dart'; // Asegúrate de que este modelo esté correctamente definido
import 'package:gad/Service/Dispositivos-PC-Servicio.dart'; // Importa el servicio donde guardas los datos

class AgregarDispositivoScreen extends StatefulWidget {
  @override
  _AgregarDispositivoScreenState createState() =>
      _AgregarDispositivoScreenState();
}

class _AgregarDispositivoScreenState extends State<AgregarDispositivoScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos
  final modeloController = TextEditingController();
  final areaController = TextEditingController();
  final servicioController = TextEditingController();
  final tipoController = TextEditingController();
  final observacionesController = TextEditingController();
  final marcaTemporalController = TextEditingController();
  final ipController = TextEditingController();

  // Instancia del servicio
  final InventarioServiceDispositivos _inventarioService =
      InventarioServiceDispositivos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Dispositivo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: modeloController,
                decoration: InputDecoration(labelText: 'Modelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el modelo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: areaController,
                decoration: InputDecoration(labelText: 'Área'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el área';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: servicioController,
                decoration: InputDecoration(labelText: 'Servicio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el servicio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tipoController,
                decoration: InputDecoration(labelText: 'Tipo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el tipo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: observacionesController,
                decoration: InputDecoration(labelText: 'Observaciones'),
              ),
              TextFormField(
                controller: marcaTemporalController,
                decoration: InputDecoration(labelText: 'Marca Temporal'),
              ),
              TextFormField(
                controller: ipController,
                decoration: InputDecoration(labelText: 'IP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la IP';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Crear una instancia de tu modelo
                    InventarioPCs nuevoDispositivo = InventarioPCs(
                      modelo: modeloController.text,
                      area: areaController.text,
                      servicio: servicioController.text,
                      tipo: tipoController.text,
                      observaciones: observacionesController.text,
                      marcaTemporal: marcaTemporalController.text.isNotEmpty
                          ? marcaTemporalController.text
                          : DateTime.now()
                              .toString(), // Si la marca temporal está vacía, usa la fecha actual
                      ip: ipController.text,
                    );

                    // Llamar al servicio para guardar el dispositivo
                    await _inventarioService
                        .guardarInventario(nuevoDispositivo);

                    // Mostrar mensaje de éxito y regresar a la pantalla anterior
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Dispositivo guardado con éxito')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
