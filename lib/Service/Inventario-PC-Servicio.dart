import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gad/Model/Inventario-PC-model.dart';

class InventarioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "Inventario-PCs";

  // Método para guardar un inventario en Firestore
Future<void> guardarInventario(InventarioPCs inventario) async {
  try {
    Map<String, dynamic> inventarioData = inventario.toJson();

    // Usar un ID personalizado
    String customId = inventario.idPc;

    // Usar `set()` con el ID personalizado
    await _firestore.collection(collectionName).doc(customId).set(inventarioData);

    print("Inventario guardado con éxito con ID personalizado: $customId");
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
// Método para actualizar un inventario existente en Firestore
  Future<void> actualizarInventario(InventarioPCs inventario) async {
    try {
      // Verificar que el ID no sea nulo
      if (inventario.idPc == null) {
        throw Exception("El ID del inventario no puede ser nulo.");
      }

      // Convertir el objeto InventarioPCs a JSON
      Map<String, dynamic> inventarioData = inventario.toJson();

      // Actualizar el inventario en Firestore usando el ID del documento
      await _firestore
          .collection(collectionName)
          .doc(inventario.idPc) // Utiliza el ID para identificar el documento
          .update(inventarioData);

      print("Inventario actualizado con éxito");
    } catch (e) {
      print("Error al actualizar el inventario: $e");
    }
  }

  // Método para eliminar un inventario de Firestore
  Future<void> eliminarPC(String idPC) async {
    try {
      await _firestore.collection(collectionName).doc(idPC).delete();
      print("PC eliminada exitosamente.");
    } catch (e) {
      print('Error al eliminar el inventario: $e');
    }
  }
}
