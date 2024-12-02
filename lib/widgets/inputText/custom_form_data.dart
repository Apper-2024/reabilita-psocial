import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

  const CustomFormData(
      {super.key,
      required this.labelText,
      this.onChanged,
      this.formController,
      this.validator,
      this.suffixIcon,
      this.prefixIcon,
      this.inputFormatters,
      this.onSaved});

  @override
  _CustomFormDataState createState() => _CustomFormDataState();
}

class _CustomFormDataState extends State<CustomFormData> {
  final DateFormat _dateFormat = DateFormat("dd/MM/yyyy");

  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    DateTime hundredYearsAgo = DateTime(now.year - 100, now.month, now.day);

    var data = await showDatePicker(
      context: context,
      firstDate: hundredYearsAgo,
      lastDate: now,
      initialDate: now,
    );

    if (data != null) {
      if (mounted) {
        setState(() {
          widget.formController?.text = _dateFormat.format(data);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      controller: widget.formController,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      readOnly: true,
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
          labelText: widget.labelText,
          hintStyle: const TextStyle(color: cinza1, fontWeight: FontWeight.w600, fontSize: 12),
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
          floatingLabelStyle: const TextStyle(color: Colors.green), // Define a cor do label quando focado
          alignLabelWithHint: true),
      onTap: () {
        _selectDate();
      },
    );
  }
}