import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reabilita_social/utils/colors.dart';

class CustomFormData extends StatefulWidget {
  final String labelText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? formController;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onSaved;

  const CustomFormData({
    super.key,
    required this.labelText,
    this.onChanged,
    this.formController,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatters,
    this.onSaved,
  });

  @override
  State<CustomFormData> createState() => _CustomFormDataState();
}

class _CustomFormDataState extends State<CustomFormData> {
  final DateFormat _dateFormat = DateFormat("dd/MM/yyyy", "pt_BR");

  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    DateTime hundredYearsAgo = DateTime(now.year - 100, now.month, now.day);

    // Abre o seletor de datas
    var selectedDate = await showDatePicker(
      context: context,
      firstDate: hundredYearsAgo,
      lastDate: now,
      initialDate: now,
      locale: const Locale("pt", "BR"), // Localização para PT-BR
    );

    if (selectedDate != null) {
      if (mounted) {
        setState(() {
          widget.formController?.text = _dateFormat.format(selectedDate);
        });
      }
    }
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor, insira uma data válida.";
    }

    try {
      DateTime parsedDate = _dateFormat.parse(value);
      DateTime now = DateTime.now();
      DateTime hundredYearsAgo = DateTime(now.year - 100, now.month, now.day);

      if (parsedDate.isAfter(now)) {
        return "A data não pode estar no futuro.";
      } else if (parsedDate.isBefore(hundredYearsAgo)) {
        return "A data é muito antiga. Verifique se está correta.";
      }
    } catch (e) {
      return "Data inválida.";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      controller: widget.formController,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      validator: (value) =>
          widget.validator?.call(value) ?? _validateDate(value),
      readOnly: true, // Define que o campo é apenas leitura
      buildCounter: (context,
          {required currentLength, required isFocused, required maxLength}) {
        return null;
      },
      cursorColor: preto1,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: preto1, width: 1),
        ),
        labelText: widget.labelText,
        hintStyle: const TextStyle(
            color: cinza1, fontWeight: FontWeight.w600, fontSize: 12),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: verde1, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: verde1, width: 2),
        ),
        floatingLabelStyle: const TextStyle(color: Colors.green),
        alignLabelWithHint: true,
      ),
      onTap: () {
        _selectDate(); // Abre o calendário ao clicar no campo
      },
    );
  }
}
