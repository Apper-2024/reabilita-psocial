import 'package:flutter/material.dart';

// Input genérico com parâmetros personalizáveis
class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final double width;
  CustomInputField({
    required this.label,
    required this.hintText,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
