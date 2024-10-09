import 'package:flutter/material.dart';
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
  final encargadoController =TextEditingController();
  final codigoActFijosDispositivosController = TextEditingController();

  // Instancia del servicio
  final InventarioServiceDispositivos _inventarioService =
      InventarioServiceDispositivos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Dispositivo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alineación izquierda
              children: [
                TextFormField(
                  controller: marcaTemporalController,
                  decoration: const InputDecoration(labelText: 'Marca Temporal'),
                ),
                TextFormField(
                  controller: ipController,
                  decoration: const InputDecoration(labelText: 'IP'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la IP';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: modeloController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el modelo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: areaController,
                  decoration: const InputDecoration(labelText: 'Área'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el área';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: servicioController,
                  decoration: const InputDecoration(labelText: 'Servicio'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el servicio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: tipoController,
                  decoration: const InputDecoration(labelText: 'Tipo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el tipo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: observacionesController,
                  decoration: const InputDecoration(labelText: 'Observaciones'),
                ),
                TextFormField(
                  controller: encargadoController,
                  decoration: const InputDecoration(labelText: 'Encargado del dispositivo'),
                ),
                TextFormField(
                  controller: codigoActFijosDispositivosController,
                  decoration: const InputDecoration(labelText: 'Codigo Act Fijos'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la IP';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Crear una instancia de tu modelo
                        Dispositivos nuevoDispositivo = Dispositivos(
                          marcaTemporal: marcaTemporalController.text.isNotEmpty
                              ? marcaTemporalController.text
                              : DateTime.now()
                                  .toString(), // Si la marca temporal está vacía, usa la fecha actual
                          ip: ipController.text,
                          modelo: modeloController.text,
                          area: areaController.text,
                          servicio: servicioController.text,
                          tipo: tipoController.text,
                          encargado: encargadoController.text,
                          codigoActFijosDispositivos: codigoActFijosDispositivosController.text,
                          observaciones: observacionesController.text,

                        );

                        // Llamar al servicio para guardar el dispositivo
                        await _inventarioService
                            .guardarInventario(nuevoDispositivo);

                        // Mostrar mensaje de éxito y regresar a la pantalla anterior
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Dispositivo guardado con éxito')),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
