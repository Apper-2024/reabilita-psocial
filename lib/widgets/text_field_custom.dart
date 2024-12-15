import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reabilita_social/utils/colors.dart';

class TextFieldCustom extends StatelessWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? formController;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? senha;
  final List<TextInputFormatter>? inputFormatters;
  final int? caracterMax;
  final TextInputType tipoTexto;
  final Function(String?)? onSaved;
  final String? valorInicial;
  final int? maxLines;
  final int? minLines;
  const TextFieldCustom(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.onChanged,
      this.senha,
      this.formController,
      this.validator,
      this.suffixIcon,
      this.prefixIcon,
      this.inputFormatters,
      this.caracterMax,
      required this.tipoTexto,
      this.onSaved,
      this.valorInicial,
      this.maxLines,
      this.minLines});

  @override
  Widget build(BuildContext context) => TextFormField(
        onSaved: onSaved,
        controller: formController,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: tipoTexto,
        validator: validator,
        maxLength: caracterMax,
        obscureText: senha ?? false,
        maxLines: maxLines ?? 1,
        
        minLines: minLines ?? 1,
        initialValue: valorInicial,
        buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
          return null;
        },
        cursorColor: preto1,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: preto1, width: 1), // Borda preta quando não está focado
            ),
            labelText: labelText,
            hintText: hintText,
            hintStyle: const TextStyle(color: cinza1, fontWeight: FontWeight.w600, fontSize: 12),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: verde1, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: verde1, width: 2),
            ),
            floatingLabelStyle: const TextStyle(color: Colors.green), // Define a cor do label quando focado
            alignLabelWithHint: true),
      );
}
