import 'dart:typed_data';
import 'package:flutter/material.dart';

class Anexo extends StatelessWidget {
  final Uint8List arquivoBytes;

  const Anexo({super.key, required this.arquivoBytes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.memory(
          arquivoBytes,
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}