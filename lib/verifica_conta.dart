import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/enum/enum_tipo_usuario.dart';
import 'package:reabilita_social/provider/administrador_provider.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/repository/administrador/gerencia_administrador_repository.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';
import 'package:reabilita_social/repository/profissional/gerencia_profissional_repository.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/widgets/bottomMenu/botom_menu_profissional.dart';

class VerificaConta extends StatelessWidget {
  const VerificaConta({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return FutureBuilder<void>(
            future: verificaUser(context, user),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const BottomMenuProfissional();
              } else {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

Future<void> verificaUser(BuildContext context, User user) async {
  try {
    final usuario = await AuthRepository().buscaUsuario(user.uid);
    if (usuario == null) {
      snackErro(context, "Usuário não encontrado");
      await AuthRepository().signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      return;
    }

    if (usuario.tipoUsuario == EnumTipoUsuario.profissional.name) {
      ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;
      final profissional = await GerenciaProfissionalRepository().buscaProfissional(usuario.uid);
      profissionalProvider.setProfissional(profissional);
      Navigator.pushNamedAndRemoveUntil(context, '/menuProfissional', (route) => false);
    }

    if (usuario.tipoUsuario == EnumTipoUsuario.administrador.name) {
      AdministradorProvider administradorProvider = AdministradorProvider.instance;
      final administrador = await GerenciaAdministradorRepository().buscaAdministrador(usuario.uid);
      administradorProvider.setAdministrador(administrador);
      Navigator.pushNamedAndRemoveUntil(context, '/usuariosAdministrador', (route) => false);
    }

    // Navegue para o menu principal
  } catch (e) {
    snackErro(context, "Erro ao verificar usuário: $e");
    await AuthRepository().signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
