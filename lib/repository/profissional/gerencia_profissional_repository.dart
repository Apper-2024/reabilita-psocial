import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reabilita_social/enum/enum_tipo_usuario.dart';
import 'package:reabilita_social/model/profissional/profissional_model.dart';
import 'package:reabilita_social/model/usuario_model.dart';
import 'package:reabilita_social/repository/FirebaseError/firebase_error_repository.dart';

class GerenciaProfissionalRepository {
  final db = FirebaseFirestore.instance;

  Future<ProfissionalModel> buscaProfissional(String uid) async {
    try {
      final unidadeDoc = await db.collection('Profissionais').doc(uid).get();

      return ProfissionalModel.fromMap(unidadeDoc.data()!);
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> criaProfissional(UserCredential usuario, ProfissionalModel profissional) async {
    WriteBatch batch = db.batch();
    try {
      UsuarioModel usuarioModel = UsuarioModel(
        uid: usuario.user!.uid,
        email: usuario.user!.email!,
        tipo: EnumTipoUsuario.profissional.name,
      );
      profissional.uidProfissional = usuario.user!.uid;
      
      batch.set(db.collection("Profissionais").doc(usuario.user!.uid), profissional.toMap());

      batch.set(db.collection("Usuarios").doc(usuario.user!.uid), usuarioModel.toMap());

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }
}
