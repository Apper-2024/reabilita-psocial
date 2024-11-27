import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reabilita_social/model/usuario_model.dart';
import 'package:reabilita_social/repository/FirebaseError/firebase_error_repository.dart';
import 'package:reabilita_social/services/firebase_service.dart';

class AuthRepository {
  FirebaseFirestore db = FirebaseService().db;
  FirebaseAuth auth = FirebaseService().auth;

  Future<User> fazerLogin(String email, String senha) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(email: email, password: senha);

      final user = userCredential.user;
      if (user == null) {
        throw 'Usuário não encontrado';
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseAuthException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> trocarSenha(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseAuthException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<UserCredential> criarUsuario(String email, String senha) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(email: email, password: senha);
      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseAuthException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<UsuarioModel?> buscaUsuario(String uid) async {
    try {
      final responsavelSnapshot = await db.collection('Usuarios').doc(uid).get();
      if (responsavelSnapshot.exists) {
        return UsuarioModel.fromMap(responsavelSnapshot.data() as Map<String, dynamic>);
      }
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
    return null;
  }

  // Future<Map<String, Object>?> verificaUsuarioPendente(String email, int senha) async {
  //   try {
  //     final responsavelSnapshot = await db
  //         .collectionGroup('UsuariosPendentes')
  //         .where("email", isEqualTo: email)
  //         .where("senha", isEqualTo: senha)
  //         .limit(1)
  //         .get();
  //     if (responsavelSnapshot.docs.isNotEmpty) {
  //       return {
  //         'usuario': UsuarioModel.fromMap(responsavelSnapshot.docs.first.data()),
  //         'uidColletion': responsavelSnapshot.docs.first.id
  //       };
  //     }
  //   } on FirebaseException catch (e) {
  //     throw FirebaseErrorRepository.handleFirebaseException(e);
  //   } catch (e) {
  //     throw 'Ops, algo deu errado. Tente novamente mais tarde!';
  //   }
  //   return null;
  // }
}
