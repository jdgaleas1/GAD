
import 'package:flutter/material.dart';
import 'package:gad/Model/Temas-Estados.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onItemTapped;

  CustomDrawer({
    super.key,
    required this.onItemTapped,
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
              onItemTapped(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.visibility ),
            title: const Text('Reservas Hechas'),
            onTap: () {
              onItemTapped(1);
              Navigator.pop(context);
            },
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
