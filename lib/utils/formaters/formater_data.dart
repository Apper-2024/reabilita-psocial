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
