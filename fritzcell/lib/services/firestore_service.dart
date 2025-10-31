import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> registrarDiagnostico({
    required String tipo,
    required bool resultadoPositivo,
  }) async {
    await _db.collection('diagnosticos').add({
      'tipo': tipo,
      'resultado': resultadoPositivo ? 'Positivo' : 'Negativo',
      'data': DateTime.now().toIso8601String(),
    });
  }
}
