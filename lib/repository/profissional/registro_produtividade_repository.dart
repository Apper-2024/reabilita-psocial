import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroProdutividadeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> getUserRecords() async {
    final user = _auth.currentUser;

    if (user == null) {
      return [];
    }

    final snapshot = await _firestore
        .collection('Profissionais')
        .doc(user.uid)
        .collection('RegistroProdutividade')
        .get();

    return snapshot.docs
        .map((doc) => {"id": doc.id, ...doc.data()})
        .toList();
  }

  Future<void> saveUserRecord(Map<String, dynamic> record) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    await _firestore
        .collection('Profissionais')
        .doc(user.uid)
        .collection('RegistroProdutividade')
        .add(record);
  }

  Future<void> deleteUserRecord(String recordId) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    await _firestore
        .collection('Profissionais')
        .doc(user.uid)
        .collection('RegistroProdutividade')
        .doc(recordId)
        .delete();
  }
}