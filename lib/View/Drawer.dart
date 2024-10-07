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

  CustomDrawer({
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
            decoration: BoxDecoration(
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
            leading: Icon(Icons.fact_check),
            title: Text('Inventario Nuevo'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AgregarPCs()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('Ver Dispositivos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InventarioTabla()),
              );
            },
          ),
          // Nuevo ListTile para agregar dispositivos
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Agregar Dispositivos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AgregarDispositivoScreen()),
              );
            },
          ),
          // ExpansionTile para Importar/Exportar
          ExpansionTile(
            leading: Icon(Icons.import_export),
            title: Text('Importar/Exportar'),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.upload_file),
                title: Text('Importar'),
                onTap: () {
                  seleccionarArchivoExcel();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text('Exportar'),
                onTap: () {
                  exportarDatos();
                  Navigator.pop(context);
                },
              ),
            ],
          ),

          // Configuración
          ExpansionTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            children: <Widget>[
              SwitchListTile(
                title: Text('Tema Claro'),
                value: Provider.of<ThemeProvider>(context).getTheme() ==
                    AppThemes.lightTheme,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(AppThemes.lightTheme);
                },
              ),
              SwitchListTile(
                title: Text('Tema Oscuro'),
                value: Provider.of<ThemeProvider>(context).getTheme() ==
                    AppThemes.darkTheme,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(AppThemes.darkTheme);
                },
              ),
              SwitchListTile(
                title: Text('Tema Azul'),
                value: Provider.of<ThemeProvider>(context).getTheme() ==
                    AppThemes.blueTheme,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(AppThemes.blueTheme);
                },
              ),
              SwitchListTile(
                title: Text('Tema Rosa'),
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
