import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gad/Model/Dispositivos-PC-model.dart';

class InventarioServiceDispositivos {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "dispositivoss";

  // Método para guardar un inventario en Firestore
  Future<void> guardarInventario(Dispositivos inventario) async {
    try {
      Map<String, dynamic> inventarioData = inventario.toJson();

      // Usar un ID personalizado basado en la marca temporal
      String customId = inventario.marcaTemporal;

      // Usar `set()` con el ID personalizado
      await _firestore
          .collection(collectionName)
          .doc(customId)
          .set(inventarioData);

      print("Inventario guardado con éxito con ID personalizado: $customId");
    } catch (e) {
      print("Error al guardar el inventario: $e");
    }
  }

  // Método para obtener todos los inventarios desde Firestore
  Future<List<Dispositivos>> obtenerInventario() async {
    try {
      // Consulta todos los documentos en la colección "Inventario-PCs"
      QuerySnapshot querySnapshot =
          await _firestore.collection(collectionName).get();

      // Extraer los datos y convertirlos en una lista de objetos Dispositivos
      List<Dispositivos> inventarios = querySnapshot.docs.map((doc) {
        return Dispositivos.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return inventarios;
    } catch (e) {
      print("Error al obtener el inventario: $e");
      return [];
    }
  }

  // Método para actualizar un inventario existente en Firestore
  Future<void> actualizarInventario(Dispositivos inventario) async {
    try {
      // Verificar que el ID no sea nulo
      if (inventario.marcaTemporal.isEmpty) {
        throw Exception(
            "La marca temporal del inventario no puede estar vacía.");
      }

      // Convertir el objeto Dispositivos a JSON
      Map<String, dynamic> inventarioData = inventario.toJson();

      // Actualizar el inventario en Firestore usando el ID del documento
      await _firestore
          .collection(collectionName)
          .doc(inventario.marcaTemporal) // Utiliza la marca temporal como ID
          .update(inventarioData);

      print("Inventario actualizado con éxito");
    } catch (e) {
      print("Error al actualizar el inventario: $e");
    }
  }

  // Método para eliminar un inventario de Firestore
  Future<void> eliminarPC(String marcaTemporal) async {
    try {
      await _firestore.collection(collectionName).doc(marcaTemporal).delete();
      print("PC eliminada exitosamente.");
    } catch (e) {
      print('Error al eliminar el inventario: $e');
    }
  }
}
