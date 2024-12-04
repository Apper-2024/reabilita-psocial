import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var cepFormater =
    MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
var cpfFormater =
    MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
var telefoneFormater =
    MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

var cnpjFormater = MaskTextInputFormatter(
    mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

var numeroFormater =
    MaskTextInputFormatter(mask: '######', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ ${formatter.format(value / 100)}";

    return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
  }

}
   int calculaIdade(String birthDateString) {
    try {
      DateFormat format = DateFormat('dd/MM/yyyy');
      DateTime birthDate = format.parseStrict(birthDateString);
      DateTime today = DateTime.now();

      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      print('Erro ao calcular idade: $e');
      return 0;
    }
  }

  String? formatTimesTamp(Timestamp? timestamp) {
  if (timestamp == null) return null;

  try {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  } catch (e) {
    return null;
  }
}
