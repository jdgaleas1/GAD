import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gad/Model/Inventario-PC-model.dart';

class InventarioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "prueba";

  // Método para guardar un inventario en Firestore
Future<void> guardarInventario(InventarioPCs inventario) async {
  try {
    // Convertir el objeto InventarioPCs a JSON
    Map<String, dynamic> inventarioData = inventario.toJson();

    // Guardar el inventario en Firestore sin especificar el ID (se generará automáticamente)
    await _firestore
        .collection(collectionName)
        .add(inventarioData);

    print("Inventario guardado con éxito");
  } catch (e) {
    print("Error al guardar el inventario: $e");
  }
}


  Future<List<InventarioPCs>> obtenerInventario() async {
    try {
      // Consulta todos los documentos en la colección "Inventario-PCs"
      QuerySnapshot querySnapshot =
          await _firestore.collection(collectionName).get();

      // Extraer los datos y convertirlos en una lista de objetos InventarioPCs
      List<InventarioPCs> inventarios = querySnapshot.docs.map((doc) {
        return InventarioPCs.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return inventarios;
    } catch (e) {
      print("Error al obtener el inventario: $e");
      return [];
    }
  }
}
