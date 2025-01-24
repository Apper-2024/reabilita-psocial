import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reabilita_social/model/administrador/administrador_model.dart';
import 'package:reabilita_social/repository/FirebaseError/firebase_error_repository.dart';

class GerenciaAdministradorRepository {
  final db = FirebaseFirestore.instance;

  Future<AdministradorModel> buscaAdministrador(String uid) async {
    try {
      print('Iniciando busca do administrador...');
      print('UID recebido: $uid');

      final unidadeDoc = await db.collection('Administrador').doc(uid).get();
      print('Documento encontrado no Firestore? ${unidadeDoc.exists}');
      if (!unidadeDoc.exists) {
        print('Nenhum administrador encontrado com o UID: $uid');
        throw Exception('Administrador não encontrado.');
      }

      final data = unidadeDoc.data();
      print('Dados do documento: $data');

      final administrador = AdministradorModel.fromMap(data!);
      print('AdministradorModel criado: $administrador');

      return administrador;
    } on FirebaseException catch (e) {
      print('Erro de FirebaseException: ${e.message}');
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print('Erro inesperado: $e');
      throw 'Ops, algo deu erradoooooo';
    }
  }
}
