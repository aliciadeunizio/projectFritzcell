import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> registrarDiagnostico({
    required String tipo,
    required bool concluido,
  }) async {
    await _db.collection('diagnosticos').add({
      'tipo': tipo,
      'concluido': concluido, // campo booleano
      'data': DateTime.now().toIso8601String(),
    });
  }
}
