
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseErrorRepository {
  static String handleSupabaseAuthException(AuthException e) {
    switch (e.message) {
      case 'Invalid login credentials':
        return 'Credenciais de login inválidas.';
      case 'Email not confirmed':
        return 'E-mail não confirmado.';
      case 'User not found':
        return 'Nenhum usuário encontrado para esse e-mail.';
      case 'Password recovery link expired':
        return 'O link de recuperação de senha expirou.';
      case 'Password recovery link already used':
        return 'O link de recuperação de senha já foi usado.';
      case 'Invalid or expired token':
        return 'Token inválido ou expirado.';
      case 'User already registered':
        return 'Usuário já registrado.';
      case 'Email already registered':
        return 'E-mail já registrado.';
      case 'Invalid email':
        return 'E-mail inválido.';
      case 'Invalid password':
        return 'Senha inválida.';
      default:
        print(e);
        return 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }
}
