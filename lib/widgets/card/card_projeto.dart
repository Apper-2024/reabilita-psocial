import 'package:flutter/material.dart';
import 'package:reabilita_social/repository/paciente/gerencia_paciente_repository.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';

class CardProjeto extends StatelessWidget {
  final String foto;
  final String nome;
  final String observacao;
  final String? uid;
  final void Function()? onTap;

  const CardProjeto({
    super.key,
    required this.foto,
    required this.nome,
    required this.observacao,
    this.uid,
    this.onTap,
  });

  void _showObservacao(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Observação',
            style: TextStyle(color: preto1),
          ),
          content: Text(
            observacao,
            style: const TextStyle(color: preto1),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: verde1,
              ),
              child: const Text(
                'Fechar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> modalCerteza(String uid, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(26),
                  child: Column(
                    children: [
                      const Text(
                        'Tem certeza que deseja excluir o paciente?',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          color: preto1,
                        ),
                      ),
                          const SizedBox(height: 15),

                      Row(
                        children: [
                          Expanded(
                            child: Botaoprincipal(
                                cor: verde1,
                                text: "Cancelar exclusão",
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Botaoprincipal(
                                cor: vermelho,
                                text: "Excluir",
                                onPressed: () async {
                                  await GerenciaPacienteRepository().excluirPaciente(uid);

                                  Navigator.of(context).pop();
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(foto),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    color: verde1,
                  ),
                  maxLines: null,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.info_outline, color: verde1),
                    onPressed: () => _showObservacao(context),
                  ),
                  Visibility(
                    visible: uid != null,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: verde1),
                      onPressed: () => modalCerteza(uid!, context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
