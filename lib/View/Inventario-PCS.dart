import 'package:flutter/material.dart';

class AgregarPCs extends StatefulWidget {
  const AgregarPCs({super.key});

  @override
  _AgregarPCsState createState() => _AgregarPCsState();
}

class _AgregarPCsState extends State<AgregarPCs> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController marcacontroller = TextEditingController();
  TextEditingController unidadController = TextEditingController();
  TextEditingController NombrePCcontroller = TextEditingController();
  TextEditingController IPcontroller = TextEditingController();
  TextEditingController NombreFuncionariocontroller = TextEditingController();
  TextEditingController puestoFuncionariocontroller = TextEditingController();
  TextEditingController redConectadacontroller = TextEditingController();
  TextEditingController nombreRedcontroller = TextEditingController();
  TextEditingController dns1controller = TextEditingController();
  TextEditingController dns2controller = TextEditingController();
  TextEditingController sistemaOperativocontroller = TextEditingController();
  TextEditingController maquinaTodoEnUnoController = TextEditingController();
  TextEditingController CaracteristicasController = TextEditingController();
  TextEditingController laptopController = TextEditingController();
  TextEditingController codigoController = TextEditingController(); 
  TextEditingController estadoPCController = TextEditingController(); 


  _guardarPC() async {
      
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
              TextFormField(
                controller: unidadController,
                decoration: const InputDecoration(labelText: 'Unidad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la Unidad';
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
              TextFormField(
                controller: NombreFuncionariocontroller,
                decoration:
                    const InputDecoration(labelText: 'Nombre del funcionario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el Nombre del funcionario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: puestoFuncionariocontroller,
                decoration: const InputDecoration(
                    labelText: 'Puesto que ocupa el funcionario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el Puesto que ocupa el uncionario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: redConectadacontroller,
                decoration: const InputDecoration(labelText: 'Red conectada'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la Red conectada';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nombreRedcontroller,
                decoration: const InputDecoration(labelText: 'Nombre de red'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingrese el Nombre de red';
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
                decoration:
                    const InputDecoration(labelText: 'Sitema Operativo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el Sitema Operativo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: maquinaTodoEnUnoController,
                decoration:
                    const InputDecoration(labelText: 'Maquina Todo en Uno'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la Maquina Todo en Uno';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: CaracteristicasController,
                decoration:
                    const InputDecoration(labelText: 'Caracteristicas PC'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese las Caracteristicas PC';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: laptopController,
                decoration: const InputDecoration(labelText: 'Laptop'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese si es laptop o no';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: codigoController,
                decoration:
                    const InputDecoration(labelText: 'CODIGO ACT FIJOS'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese CODIGO ACT FIJOS';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: estadoPCController,
                decoration:
                    const InputDecoration(labelText: 'Estado de Computadora'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el Estado de la Computadora';
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
                      Navigator.pop(
                          context, true); // Devuelve true si se agregó un auto.
                    },
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.white)),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
