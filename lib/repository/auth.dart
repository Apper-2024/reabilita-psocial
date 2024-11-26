import 'package:reabilita_social/repository/FirebaseError/supabase_error_repository.dart';
import 'package:reabilita_social/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient supabase = SupabaseService().client;

  Future<void> fazerLogin(String email, String senha) async {
    try {
      await supabase.auth.signInWithPassword(password: senha, email: email);
    } on AuthException catch (e) {
      throw SupabaseErrorRepository.handleSupabaseAuthException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> deslogar() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (e) {
      throw SupabaseErrorRepository.handleSupabaseAuthException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> criarUsuario(String email, String senha) async {
    try {
      await supabase.auth.signUp(password: senha, email: email);
    } on AuthException catch (e) {
      throw SupabaseErrorRepository.handleSupabaseAuthException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }
}
