import 'package:flutter/material.dart';
import 'package:gad/View/Inventario-PCS.dart';
import 'package:gad/View/Dispositivos-PCS.dart';
import 'package:gad/View/home-dispositivos.dart';
import 'package:provider/provider.dart';
import 'package:gad/Model/Temas-Estados.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onItemTapped;
  final VoidCallback seleccionarArchivoExcel;
  final VoidCallback exportarDatos;

  const CustomDrawer({
    super.key,
    required this.onItemTapped,
    required this.seleccionarArchivoExcel,
    required this.exportarDatos,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/gad_drawer.png'),
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Container(),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'),
                radius: 40,
              ),
              const SizedBox(height: 10),
              Text(
                'GAD EC',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.fact_check),
            title: const Text('Inventario Nuevo'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AgregarPCs()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('Ver Dispositivos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InventarioTabla()),
              );
            },
          ),  
          // Nuevo ListTile para agregar dispositivos
          ListTile(
            leading: const Icon(Icons.add_circle),
            title: const Text('Agregar Dispositivos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AgregarDispositivoScreen()),
              );
            },
          ),
          // El nuevo ExpansionTile para Importar/Exportar
          ExpansionTile(
            leading: const Icon(Icons.import_export),
            title: const Text('Importar/Exportar'),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text('Importar'),
                onTap: () {
                  seleccionarArchivoExcel(); // Llama a la función de importar
                  Navigator.pop(context); // Cierra el drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Exportar'),
                onTap: () {
                exportarDatos(); // 
                  Navigator.pop(context); // Cierra el drawer
                },
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            children: <Widget>[
              SwitchListTile(
                title: const Text('Tema Claro'),
                value: Provider.of<ThemeProvider>(context).getTheme() ==
                    AppThemes.lightTheme,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(AppThemes.lightTheme);
                },
              ),
              SwitchListTile(
                title: const Text('Tema Oscuro'),
                value: Provider.of<ThemeProvider>(context).getTheme() ==
                    AppThemes.darkTheme,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(AppThemes.darkTheme);
                },
              ),
              SwitchListTile(
                title: const Text('Tema Azul'),
                value: Provider.of<ThemeProvider>(context).getTheme() ==
                    AppThemes.blueTheme,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(AppThemes.blueTheme);
                },
              ),
              SwitchListTile(
                title: const Text('Tema Rosa'),
                value: Provider.of<ThemeProvider>(context).getTheme() ==
                    AppThemes.pinkTheme,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(AppThemes.pinkTheme);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
