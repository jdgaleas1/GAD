import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gad/Model/Inventario-PC-model.dart'; // Asegúrate de importar tu modelo
import 'package:gad/Service/Inventario-PC-Servicio.dart'; // Asegúrate de importar el servicio

class AgregarPCs extends StatefulWidget {
  const AgregarPCs({super.key});

  @override
  _AgregarPCsState createState() => _AgregarPCsState();
}

class _AgregarPCsState extends State<AgregarPCs> {
  final _formKey = GlobalKey<FormState>();

  // Controladores
  TextEditingController idPCCOntroller = TextEditingController();
  TextEditingController marcacontroller = TextEditingController();
  TextEditingController nombrePCcontroller = TextEditingController();
  TextEditingController ipController = TextEditingController();
  TextEditingController nombreFuncionariocontroller = TextEditingController();
  TextEditingController puestoFuncionariocontroller = TextEditingController();
  TextEditingController dns1controller = TextEditingController();
  TextEditingController dns2controller = TextEditingController();
  TextEditingController sistemaOperativocontroller = TextEditingController();
  TextEditingController caracteristicasController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController dominioController = TextEditingController();
  TextEditingController programasLicenciasController = TextEditingController();
  TextEditingController ipRestringidasController = TextEditingController();
  TextEditingController observacionesController = TextEditingController();

  // Variables para Dropdowns
  String? unidadSeleccionada;
  String? redConectadaSeleccionada;
  String? nombreRedSeleccionada;
  String? maquinaTodoEnUnoSeleccionada;
  String? laptopSeleccionada;
  String? estadoPCSeleccionado;

  // Listas para Dropdowns
  List<String> unidades = ['Fiscalización', 'Obras Públicas', 'Contabilidad', 'Inventario y Activos Fijos', 'Unidad de Presupuesto',
    'Gestión Financiera', 'Unidad de Comunicación', 'Comunicación-La Radio', 'Talleres', 'Contabilidad-Patronato', 'Salud Ocupacional',
    'Unidad Administrativas', 'Planificación', 'Bodegas', 'Riego y Drenaje', 'Tesorería', 'Secretaría General', 'Viceprefectura', 'Archivo',
    'Jurídico', 'Prefectura', 'Fomento Productivo', 'Casa de Exposiciones', 'Compras Públicas', 'Talento Humano', 'Gestión de Riesgos', 'La Maná', 'Otros',
  ];

  // Controladores para valores personalizados
  TextEditingController unidadCustomController = TextEditingController();
  TextEditingController redNombreCustomController = TextEditingController();

  List<String> redConectadas = ['LAN(ETHERNET)', 'WAN(Wifi)'];
  List<String> nombreReds = ['GADCOTOPAXI', 'INVITADOS GADCOTOPAXI', 'Red', 'Sin Red', 'Otros'];
  List<String> maquinaTodoEnUnoOpciones = ['Si', 'No'];
  List<String> laptopOpciones = ['Si', 'No'];
  List<String> estadoPCOpciones = ['Buena', 'Regular', 'Mala'];

  // Instancia del servicio para guardar los datos
  final InventarioService _inventarioService = InventarioService();

  // Método para guardar los datos en la base de datos
  _guardarPC() async {
    if (_formKey.currentState!.validate()) {
              // Aquí agregamos el prefijo "PC-" al número ingresado
      String idPCFormatted = 'PC-${idPCCOntroller.text}';
      String unidadFinal = unidadSeleccionada == 'Otros' ? unidadCustomController.text : unidadSeleccionada!;
      String redNombreFinal = nombreRedSeleccionada == 'Otros' ? redNombreCustomController.text : nombreRedSeleccionada!;


      InventarioPCs nuevaPC = InventarioPCs(
        idPc: idPCFormatted,                              marcaTemporal: marcacontroller.text,
        unidad: unidadFinal ,                      ip: ipController.text,
        nombreDeLaPc: nombrePCcontroller.text,            nombreDelFuncionario: nombreFuncionariocontroller.text,
        puestoQueOcupa: puestoFuncionariocontroller.text, redConectada: redConectadaSeleccionada!,
        nombreDeRed: redNombreFinal,              dns1: dns1controller.text,
        dns2: dns2controller.text,                        sistemaOperativo: sistemaOperativocontroller.text,
        maquinaTodoEnUno: maquinaTodoEnUnoSeleccionada!,  caracteristicas: caracteristicasController.text,
        laptop: laptopSeleccionada!,                           codigoActFijos: codigoController.text,
        estadoDeComputadora: estadoPCSeleccionado!,            dominio: dominioController.text,
        programasLicencias: programasLicenciasController.text, ipRestringidas: ipRestringidasController.text,
        observaciones: observacionesController.text,
      );
      // Guardar los datos en Firestore usando el servicio
      await _inventarioService.guardarInventario(nuevaPC);
      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Guardado exitosamente')),
      );
      // Resetear el formulario o navegar de vuelta
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar PC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
                    TextFormField(
                      controller: idPCCOntroller,
                      decoration: const InputDecoration(labelText: 'ID PC'),
                      keyboardType: TextInputType.number, // Tipo de teclado solo numérico
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un id/numero que identifique esa PC';
                        }
                        return null;
                      },
                    ),
              const SizedBox(height: 10),
              TextFormField(
                controller: marcacontroller,
                decoration: const InputDecoration(labelText: 'Marca Temporal'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la marca Temporal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Unidad Dropdown
              // Unidad Dropdown con opción "Otros"
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Unidad'),
                value: unidadSeleccionada,
                items: unidades.map((String unidad) {
                  return DropdownMenuItem<String>(
                    value: unidad,
                    child: Text(unidad),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    unidadSeleccionada = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione una Unidad';
                  }
                  if (value == 'Otros' && unidadCustomController.text.isEmpty) {
                    return 'Por favor ingrese el valor de "Otros"';
                  }
                  return null;
                },
              ),

              // Mostrar TextFormField si "Otros" está seleccionado
              if (unidadSeleccionada == 'Otros')
                TextFormField(
                  controller: unidadCustomController,
                  decoration: const InputDecoration(labelText: 'Especifique Unidad'),
                  validator: (value) {
                    if (unidadSeleccionada == 'Otros' && (value == null || value.isEmpty)) {
                      return 'Por favor ingrese una Unidad';
                    }
                    return null;
                  },
                ),

              const SizedBox(height: 10),

              TextFormField(
                controller: nombrePCcontroller,
                decoration: const InputDecoration(labelText: 'Nombre de la PC'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el Nombre de la PC';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: nombreFuncionariocontroller,
                decoration: const InputDecoration(labelText: 'Nombre del Funcionario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el Nombre del Funcionario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),


              TextFormField(
                controller: puestoFuncionariocontroller,
                decoration: const InputDecoration(labelText: 'Puesto que Ocupa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el Puesto que Ocupa';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 10),
              TextFormField(
                controller: ipController,
                decoration: const InputDecoration(labelText: 'IP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la IP';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Red conectada Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Red Conectada'),
                value: redConectadaSeleccionada,
                items: redConectadas.map((String red) {
                  return DropdownMenuItem<String>(
                    value: red,
                    child: Text(red),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    redConectadaSeleccionada = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione una Red';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Nombre de Red Dropdown
              // Nombre de Red Dropdown con opción "Otros"
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Nombre de Red'),
                value: nombreRedSeleccionada,
                items: nombreReds.map((String red) {
                  return DropdownMenuItem<String>(
                    value: red,
                    child: Text(red),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    nombreRedSeleccionada = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un Nombre de Red';
                  }
                  if (value == 'Otros' && redNombreCustomController.text.isEmpty) {
                    return 'Por favor ingrese el valor de "Otros"';
                  }
                  return null;
                },
              ),

              // Mostrar TextFormField si "Otros" está seleccionado
              if (nombreRedSeleccionada == 'Otros')
                TextFormField(
                  controller: redNombreCustomController,
                  decoration: const InputDecoration(labelText: 'Especifique Nombre de Red'),
                  validator: (value) {
                    if (nombreRedSeleccionada == 'Otros' && (value == null || value.isEmpty)) {
                      return 'Por favor ingrese un Nombre de Red';
                    }
                    return null;
                  },
                ),

              const SizedBox(height: 10),

              TextFormField(
                controller: dns1controller,
                decoration: const InputDecoration(labelText: 'DNS 1'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese DNS 1';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: dns2controller,
                decoration: const InputDecoration(labelText: 'DNS 2'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese DNS 2';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: sistemaOperativocontroller,
                decoration: const InputDecoration(labelText: 'Sistema Operativo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el Sistema Operativo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Maquina Todo en Uno Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Maquina Todo en Uno'),
                value: maquinaTodoEnUnoSeleccionada,
                items: maquinaTodoEnUnoOpciones.map((String opcion) {
                  return DropdownMenuItem<String>(
                    value: opcion,
                    child: Text(opcion),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    maquinaTodoEnUnoSeleccionada = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione si es Maquina Todo en Uno';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: caracteristicasController,
                decoration: const InputDecoration(labelText: 'Caracteristicas PC'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese las Caracteristicas de la PCs';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Laptop Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Laptop'),
                value: laptopSeleccionada,
                items: laptopOpciones.map((String opcion) {
                  return DropdownMenuItem<String>(
                    value: opcion,
                    child: Text(opcion),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    laptopSeleccionada = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione si es Laptop';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: codigoController,
                decoration: const InputDecoration(labelText: 'CODIGO ACT FIJOS'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese CODIGO ACT FIJOS';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Estado de la PC Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Estado de la Computadora'),
                value: estadoPCSeleccionado,
                items: estadoPCOpciones.map((String estado) {
                  return DropdownMenuItem<String>(
                    value: estado,
                    child: Text(estado),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    estadoPCSeleccionado = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione el Estado de la Computadora';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: dominioController,
                decoration: const InputDecoration(labelText: 'Dominio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el dominio';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: programasLicenciasController,
                decoration: const InputDecoration(labelText: 'Programas y Licencias'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los programas o licencias que contenga';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: ipRestringidasController,
                decoration: const InputDecoration(labelText: 'Ip Restringidas'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese si es IP restringida';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: observacionesController,
                decoration: const InputDecoration(labelText: 'Observaciones'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese Observaciones';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _guardarPC,
                    child: const Text('Guardar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
