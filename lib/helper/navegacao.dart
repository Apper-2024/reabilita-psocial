import 'package:flutter/material.dart';
import 'package:reabilita_social/enum/enum_tipo_usuario.dart';
import 'package:reabilita_social/model/usuario_model.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';


class Navegacao {
  static void enviaParaMenu(BuildContext context, UsuarioModel usuarioModel) {
    final tipoUsuario = usuarioModel.tipo;
    if (tipoUsuario == EnumTipoUsuario.profissional.name) {
      Navigator.pushNamedAndRemoveUntil(context, '/menuPrincipal', (route) => false);
    } else if (tipoUsuario == EnumTipoUsuario.paciente.name) {
      Navigator.pushNamedAndRemoveUntil(context, '/menuPrincipal', (route) => false);
    } else if (tipoUsuario == EnumTipoUsuario.administrador.name) {
      Navigator.pushNamedAndRemoveUntil(context, '/menuPrincipal', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      AuthRepository().signOut();
    }
    }
}
