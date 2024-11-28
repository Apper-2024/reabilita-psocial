import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/enum/enum_tipo_usuario.dart';
import 'package:reabilita_social/helper/navegacao.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';
import 'package:reabilita_social/repository/profissional/gerencia_profissional_repository.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';

class VerificaConta extends StatefulWidget {
  const VerificaConta({super.key});

  @override
  _VerificaContaState createState() => _VerificaContaState();
}
class _VerificaContaState extends State<VerificaConta> {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      verificaUser(context, user);
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}

Future<void> verificaUser(BuildContext context, User user) async {
  try {
    final usuario = await AuthRepository().buscaUsuario(user.uid);

    if (usuario == null) {
      snackErro(context, "Usuário não encontrado");
      AuthRepository().signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      return;
    }

    if (usuario.tipo == EnumTipoUsuario.profissional.name) {
      ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;
      final unidade = await GerenciaProfissionalRepository().buscaProfissional(usuario.uid);
      profissionalProvider.setProfissional(unidade);
    }

    Navegacao.enviaParaMenu(context, usuario);
  } catch (e) {
    snackErro(context, "Erro ao verificar usuário");
    AuthRepository().signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}