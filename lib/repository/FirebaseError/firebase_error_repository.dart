import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorRepository {
  static String handleFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'unavailable':
        return 'Serviço indisponível, tente novamente mais tarde.';
      case 'permission-denied':
        return 'Permissão negada.';
      case 'network-error':
        return 'Erro de rede, verifique sua conexão.';
      default:
        print(e);

        return 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  static String handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Nenhum usuário encontrado para esse e-mail.';
      case 'wrong-password':
        return 'Senha errada fornecida para esse usuário.';
      case 'invalid-email':
        return 'Formato de e-mail inválido.';
      case 'user-disabled':
        return 'A conta do usuário foi desativada.';
      case 'too-many-requests':
        return 'Muitas tentativas de login falhadas. Tente novamente mais tarde.';
      case 'operation-not-allowed':
        return 'O login com e-mail e senha está desativado.';
      default:
        print(e);
        return 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }
}
