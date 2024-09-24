import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gad/Model/Inventario-PC-model.dart';


class InventarioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "Inventario-PCs";

  // Este método obtiene el siguiente ID disponible para un documento
  Future<String> _generarId() async {
    // Obtén todos los documentos de la colección
    QuerySnapshot querySnapshot = await _firestore.collection(collectionName).get();

    // Generar el siguiente ID basado en el número de documentos
    int nuevoId = querySnapshot.docs.length + 1;
    return "InventarioPC$nuevoId";
  }

  // Método para guardar un inventario en Firestore
  Future<void> guardarInventario(InventarioPCs inventario) async {
    try {
      // Generar el ID del documento
      String documentId = await _generarId();

      // Convertir el objeto InventarioPCs a JSON
      Map<String, dynamic> inventarioData = inventario.toJson();

      // Guardar el inventario en Firestore con el ID generado
      await _firestore.collection(collectionName).doc(documentId).set(inventarioData);

      print("Inventario guardado con éxito con el ID: $documentId");
    } catch (e) {
      print("Error al guardar el inventario: $e");
    }
  }

  
}
