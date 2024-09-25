import 'package:flutter/material.dart';
import 'package:gad/View/Inventario-PCS.dart';


class PCsHome extends StatefulWidget {
  const PCsHome({super.key});

  @override
  State<PCsHome> createState() => _PCsHomeState();
}

class _PCsHomeState extends State<PCsHome> {
  Future<void> _refreshPCs() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario PCs'),

      ),
      body: Center(
        child: const Text('Aquí puedes ver el inventario de PCs'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgregarPCs(),
            ),
          );
          if (result == true) {
            _refreshPCs();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
