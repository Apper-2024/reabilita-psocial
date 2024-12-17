import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reabilita_social/model/administrador/administrador_model.dart';
import 'package:reabilita_social/repository/FirebaseError/firebase_error_repository.dart';

class GerenciaAdministradorRepository {
  final db = FirebaseFirestore.instance;


   Future<AdministradorModel> buscaAdministrador(String uid) async {
    try {
      final unidadeDoc = await db.collection('Administrador').doc(uid).get();

      return AdministradorModel.fromMap(unidadeDoc.data()!);
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }
  
}


