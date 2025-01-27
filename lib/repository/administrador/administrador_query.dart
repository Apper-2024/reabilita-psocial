import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/snack/snack_sucesso.dart';

class AdmQuery {
  static final _firestore = FirebaseFirestore.instance;

  // busca
  static Future<Map<String, dynamic>?> fetchUser(
      String uid, String userType, BuildContext context) async {
    try {
      final collection =
          userType == 'Administrador' ? 'Administrador' : 'Profissionais';
      final docSnapshot =
          await _firestore.collection(collection).doc(uid).get();

      if (docSnapshot.exists) return docSnapshot.data();

      _showError(context, '$userType não encontrado!');
    } catch (e) {
      _showError(context, 'Erro ao carregar os dados: $e');
    }
    return null;
  }

  // att
  static Future<bool> atualizarStatus(
      String uid, String userType, String status, BuildContext context) async {
    try {
      final collection =
          userType == 'Administrador' ? 'Administrador' : 'Profissionais';
      await _firestore
          .collection(collection)
          .doc(uid)
          .update({'statusConta': status});

      snackSucesso(
        context,
        status == 'ativo'
            ? 'Usuário ativado com sucesso!'
            : 'Usuário suspenso!',
      );
      return true;
    } catch (e) {
      _showError(context, 'Erro ao atualizar status: $e');
    }
    return false;
  }

  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
