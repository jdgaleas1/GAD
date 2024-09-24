import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gad/Model/Temas-Estados.dart';
import 'package:gad/View/Drawer.dart';
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
      child:  MyApp(),
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
      title: 'Alquiler',
      theme: themeProvider.getTheme(),
      //  home:  LoginPage(), 
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

  @override
  void initState() {
    super.initState();

  }


  void _onItemTapped(int index) {
    if (index < _content.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:  Text("Inventario PCs"),
      ),
      body: Center(
        child: _content[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental_outlined),
            label: 'Reservas Hechas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:  Color.fromARGB(255, 110, 172, 218),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      drawer: CustomDrawer(
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
