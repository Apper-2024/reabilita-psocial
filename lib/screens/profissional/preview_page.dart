import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class PreviewPage extends StatelessWidget {
  final Uint8List fileBytes;

  const PreviewPage({super.key, required this.fileBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.memory(
                  fileBytes,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: branco),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context, fileBytes);
                    Navigator.pop(context, fileBytes);
                  },
                  child: const Icon(Icons.check),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}