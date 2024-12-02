import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class Botaoprincipal extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool? carregando;
  final Color? cor;

  const Botaoprincipal({
    super.key,
    required this.text,
    required this.onPressed,
    this.carregando,
    this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: 48,
      child: ElevatedButton(
        onPressed: carregando == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: cor ?? verde1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: carregando != null && carregando == true
            ? const CircularProgressIndicator(
                color: branco,
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
