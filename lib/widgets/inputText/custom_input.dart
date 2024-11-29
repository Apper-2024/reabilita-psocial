import 'package:flutter/material.dart';

// Input genérico com parâmetros personalizáveis
class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final double width;
  const CustomInputField({super.key, 
    required this.label,
    required this.hintText,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
