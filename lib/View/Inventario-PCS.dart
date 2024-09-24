import 'package:flutter/material.dart';

class AgregarPCs extends StatefulWidget {
  const AgregarPCs({super.key});

  @override
  _AgregarPCsState createState() => _AgregarPCsState();
}

class _AgregarPCsState extends State<AgregarPCs> {
  final _formKey = GlobalKey<FormState>();

  // Controladores
  TextEditingController marcacontroller = TextEditingController();
  TextEditingController NombrePCcontroller = TextEditingController();
  TextEditingController IPcontroller = TextEditingController();
  TextEditingController NombreFuncionariocontroller = TextEditingController();
  TextEditingController puestoFuncionariocontroller = TextEditingController();
  TextEditingController dns1controller = TextEditingController();
  TextEditingController dns2controller = TextEditingController();
  TextEditingController sistemaOperativocontroller = TextEditingController();
  TextEditingController CaracteristicasController = TextEditingController();
  TextEditingController codigoController = TextEditingController();

  // Variables para Dropdowns
  String? unidadSeleccionada;
  String? redConectadaSeleccionada;
  String? nombreRedSeleccionada;
  String? maquinaTodoEnUnoSeleccionada;
  String? laptopSeleccionada;
  String? estadoPCSeleccionado;

  // Listas para Dropdowns
  List<String> unidades = [
    'Fiscalización',
    'Obras Públicas',
    'Contabilidad',
    'Inventario y Activos Fijos',
    'Unidad de Presupuesto',
    'Gestión Financiera',
    'Unidad de Comunicación',
    'Comunicación-La Radio',
    'Talleres',
    'Contabilidad-Patronato',
    'Salud Ocupacional',
    'Unidad Administrativas',
    'Planificación',
    'Bodegas',
    'Riego y Drenaje',
    'Tesorería',
    'Secretaría General',
    'Viceprefectura',
    'Archivo',
    'Jurídico',
    'Prefectura',
    'Fomento Productivo',
    'Casa de Exposiciones',
    'Compras Públicas',
    'Talento Humano',
    'Gestión de Riesgos',
    'La Maná',
  ];

  List<String> redConectadas = ['LAN(ETHERNET)', 'WAN(Wifi)'];
  List<String> nombreReds = ['GADCOTOPAXI', 'INVITADOS GADCOTOPAXI', 'Red', 'Sin Red'];
  List<String> maquinaTodoEnUnoOpciones = ['Si', 'No'];
  List<String> laptopOpciones = ['Si', 'No'];
  List<String> estadoPCOpciones = ['Buena', 'Regular', 'Mala'];

  _guardarPC() async {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes implementar la lógica para guardar la información
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Guardado exitosamente')),
      );
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
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: NombrePCcontroller,
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
                controller: IPcontroller,
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
