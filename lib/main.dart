import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gad/Model/Temas-Estados.dart';
import 'package:gad/Service/importar-exportar.dart';
import 'package:gad/View/Drawer.dart';
import 'package:gad/View/home-inventario%20PCs.dart';
import 'package:gad/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(AppThemes.lightTheme),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtén el tema actual del ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Inventario',
      theme: themeProvider.getTheme(),
      home: MyHomePage(title: 'Inventario PCs'), // Define la home aquí
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> _content;
  int _selectedIndex = 0;

   final ImportarExportar _importarExportar = ImportarExportar();

  @override
  void initState() {
    super.initState();
    // Inicialización de los contenidos de las pestañas
    _content = [
      PCsHome (),
      Center(child: Text('Reservas Hechas')),
    ];
  }

  void _onItemTapped(int index) {
    if (index < _content.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

    // Define la función seleccionarArchivoExcel
  void seleccionarArchivoExcel() async {
    await _importarExportar.seleccionarArchivoExcel();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Datos del Excel subidos exitosamente')),
    );
  }

  // Define la función exportarDatos
  void exportarDatos() async {
    await _importarExportar.exportarDatosExcel();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Datos exportados exitosamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title), 
      ),
      body: Center(
        child: _content[_selectedIndex],
      ),
      drawer: CustomDrawer(
        onItemTapped: _onItemTapped,
        seleccionarArchivoExcel: seleccionarArchivoExcel, // Pasa la función de importar
        exportarDatos: exportarDatos, // Pasa la función de exportar
      ),
    );
  }
}
