import 'package:flutter/material.dart';
import 'package:reabilita_social/enum/enum_status_conta.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';

class StatusButton extends StatelessWidget {
  final String status;
  final bool isLoading;
  final VoidCallback onPressed;

  const StatusButton({
    super.key,
    required this.status,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
            visible: status == EnumStatusConta.analise.name,
          child: Botaoprincipal(text: "Aceitar Usuário", onPressed: onPressed)),
        const SizedBox(height: 10),
        Botaoprincipal(
            text: status == 'suspenso' ? 'Reativar Usuário' : 'Suspender Usuário',
            carregando: isLoading,
            onPressed: onPressed,
            cor: vermelho),
      ],
    );
  }
}
