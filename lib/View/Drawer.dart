
import 'package:flutter/material.dart';
import 'package:gad/Model/Temas-Estados.dart';
import 'package:gad/View/Inventario-PCS.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onItemTapped;
  final VoidCallback seleccionarArchivoExcel; // Añadir la función de importar
  final VoidCallback exportarDatos; // Añadir la función de exportar

  CustomDrawer({
    super.key,
    required this.onItemTapped,
        required this.seleccionarArchivoExcel, // Recibe la función de importar
    required this.exportarDatos, // Recibe la función de exportar
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
          // El nuevo ExpansionTile para Importar/Exportar
          ExpansionTile(
            leading: Icon(Icons.import_export),
            title: Text('Importar/Exportar'),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.upload_file),
                title: Text('Importar'),
                onTap: () {
                  seleccionarArchivoExcel(); // Llama a la función de importar
                  Navigator.pop(context); // Cierra el drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text('Exportar'),
                onTap: () {
                exportarDatos(); // 
                  Navigator.pop(context); // Cierra el drawer
                },
              ),
            ],
          ),
                  
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