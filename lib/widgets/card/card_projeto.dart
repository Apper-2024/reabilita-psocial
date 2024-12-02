// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:reabilita_social/utils/colors.dart';

class CardProjeto extends StatelessWidget {
  String foto;
  String nome;
  String observacao;
  CardProjeto({
    super.key,
    required this.foto,
    required this.nome,
    required this.observacao,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    color: verde1,
                  ),
                ),
                Text(
                  observacao,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    color: cinza1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
