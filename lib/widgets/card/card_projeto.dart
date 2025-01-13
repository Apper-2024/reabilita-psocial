import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class CardProjeto extends StatelessWidget {
  final String foto;
  final String nome;
  final String observacao;
  final void Function()? onTap;

  const CardProjeto({
    super.key,
    required this.foto,
    required this.nome,
    required this.observacao,
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
              IconButton(
                icon: const Icon(Icons.info_outline, color: verde1),
                onPressed: () => _showObservacao(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
