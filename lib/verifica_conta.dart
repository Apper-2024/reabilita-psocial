import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/enum/enum_tipo_usuario.dart';
import 'package:reabilita_social/helper/navegacao.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';
import 'package:reabilita_social/repository/profissional/gerencia_profissional_repository.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';

class VerificaConta extends StatelessWidget {
  const VerificaConta({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
            });
          }

          verificaUser(context, user!);
        }
        // Enquanto o estado de conexão estiver sendo verificado, mostra um carregador
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Future<void> verificaUser(BuildContext context, User user) async {
  try {
    final usuario = await AuthRepository().buscaUsuario(user.uid);

    if (usuario == null) {
      snackErro(context, "Usuário não encontrado");
      AuthRepository().signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }

    if (usuario!.tipo == EnumTipoUsuario.profissional.name) {
      ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;

      final unidade = await GerenciaProfissionalRepository().buscaProfissional(usuario.uid);
      profissionalProvider.setProfissional(unidade);
    } else if (usuario.tipo == EnumTipoUsuario.paciente.name) {
      // final unidade =
      //     await GerenciaEmpresaRepository().pegaUnidadesAdministrador(usuario.uidEmpresa, usuario.uidUnidade!);
      // unidadeSetorProvider.setUnidadeSetor(unidade);
    } else if (usuario.tipo == EnumTipoUsuario.administrador.name) {
      // final unidade = await GerenciaEmpresaRepository().pegaTodasUnidadesMestra(usuario.uidEmpresa);
      // unidadeSetorProvider.setUnidadeSetor(unidade);
    }

    Navegacao.enviaParaMenu(context, usuario);
  } catch (e) {
    snackErro(context, "Erro ao verificar usuário");
    AuthRepository().signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
