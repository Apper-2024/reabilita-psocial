import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class CardAjuda extends StatelessWidget {
  final String titulo;
  final String descricacao;

  const CardAjuda({
    super.key,
    required this.titulo,
    required this.descricacao,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: verde1, 
              ),
            ),
            const SizedBox(height: 6),
            Text(
              descricacao,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
