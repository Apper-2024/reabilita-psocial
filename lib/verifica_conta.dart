// verifica_conta.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  bool _isNavigated = false;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Usuário não está logado, navega para a tela de login após a construção
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_isNavigated) {
          _isNavigated = true;
          Navigator.pushReplacementNamed(context, "/login");
        }
      });
    } else {
      try {
        final usuario = await AuthRepository().buscaUsuario(user.uid);

        if (usuario == null) {
          snackErro(context, "Usuário não encontrado");
          await AuthRepository().signOut();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_isNavigated) {
              _isNavigated = true;
              Navigator.pushReplacementNamed(context, '/login');
            }
          });
          return;
        }

        if (usuario.tipo == EnumTipoUsuario.profissional.name) {
          ProfissionalProvider profissionalProvider = Provider.of<ProfissionalProvider>(context, listen: false);

          final profissional = await GerenciaProfissionalRepository().buscaProfissional(usuario.uid);
          profissionalProvider.setProfissional(profissional);
        } else if (usuario.tipo == EnumTipoUsuario.paciente.name) {
          // Implementar lógica para paciente
        } else if (usuario.tipo == EnumTipoUsuario.administrador.name) {
          // Implementar lógica para administrador
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_isNavigated) {
            _isNavigated = true;
            Navegacao.enviaParaMenu(context, usuario);
          }
        });
      } catch (e) {
        snackErro(context, "Erro ao verificar usuário");
        await AuthRepository().signOut();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_isNavigated) {
            _isNavigated = true;
            Navigator.pushReplacementNamed(context, '/login');
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}