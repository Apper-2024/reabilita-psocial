import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class TextSearch extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  const TextSearch({
    super.key,
    this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: cinza1, fontSize: 18),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Icon(Icons.search, color: cinza1),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16.0),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: background, width: 2.0),
          borderRadius: BorderRadius.circular(200),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: cinza1, width: 2.0),
          borderRadius: BorderRadius.circular(200),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
