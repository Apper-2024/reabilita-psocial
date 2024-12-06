
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reabilita_social/provider/imagem_provider.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/dropdown_custom.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';

class FieldConfig {
  final String label;
  final String hintText;
  String? valorInicial;
  final double widthFactor;
  final bool isDoubleHeight;
  final bool hasDate;
  final bool isRadioField;
  final bool isImageField;
  final bool isDropdownField;
  final List<String>? images;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onChangedDropdown;
  final String? subtopico;
  final String? data;
  final void Function()? onTapContainer;
  final bool isButtonField;
  final String? textBotao;
  final void Function()? onTapBotao;

  FieldConfig({
    required this.label,
    required this.hintText,
    this.valorInicial,
    this.widthFactor = 1.0,
    this.isDoubleHeight = false,
    this.hasDate = false,
    this.isRadioField = false,
    this.isImageField = false,
    this.isDropdownField = false,
    this.images,
    this.dropdownItems,
    this.onChangedDropdown,
    this.subtopico,
    this.data,
    this.onTapContainer,
    this.isButtonField = false,
    this.textBotao,
    this.onTapBotao,
  });
}

class FormCategoria extends StatefulWidget {
  final String titulo;
  final List<FieldConfig> fields;

  const FormCategoria({
    super.key,
    required this.titulo,
    required this.fields,
  });
  @override
  _FormCategoriaState createState() => _FormCategoriaState();
}

class _FormCategoriaState extends State<FormCategoria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          widget.titulo,
          style: const TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: background,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: _buildFieldRows(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFieldRows(BuildContext context) {
    List<Widget> rows = [];
    List<Widget> tempRow = [];

    for (var field in widget.fields) {
      if (field.isImageField) {
        if (tempRow.isNotEmpty) {
          rows.add(Row(children: tempRow));
          tempRow = [];
        }
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ImageField(
                label: field.label,
                images: field.images,
                onTapContainer: field.onTapContainer,
               ),
          ),
        );
      } else if (field.isRadioField) {
        if (tempRow.isNotEmpty) {
          rows.add(Row(children: tempRow));
          tempRow = [];
        }
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RadioField(label: field.label, value: field.hintText),
          ),
        );
      } else if (field.isDropdownField) {
        if (tempRow.isNotEmpty) {
          rows.add(Row(children: tempRow));
          tempRow = [];
        }
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CustomDropdownButton(
                dropdownValue: field.valorInicial,
                items: field.dropdownItems!,
                hint: field.hintText,
                onChanged: field.onChangedDropdown),
          ),
        );
      } else if (field.isDoubleHeight) {
        if (tempRow.isNotEmpty) {
          rows.add(Row(children: tempRow));
          tempRow = [];
        }
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: DoubleHeightInput(
              data: field.data,
              subtopico: field.subtopico,
              valorInicial: field.valorInicial,
              label: field.label,
              hintText: field.hintText,
              width: MediaQuery.of(context).size.width,
              hasDate: field.hasDate,
            ),
          ),
        );
      } else if (field.isButtonField) {
        if (tempRow.isNotEmpty) {
          rows.add(Row(children: tempRow));
          tempRow = [];
        }
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Botaoprincipal(text: field.textBotao!, onPressed: field.onTapBotao!),
          ),
        );
      } else if (field.widthFactor == 1.0) {
        if (tempRow.isNotEmpty) {
          rows.add(Row(children: tempRow));
          tempRow = [];
        }
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CustomInputForm(
              data: field.data,
              subtopico: field.subtopico,
              label: field.label,
              valorInicial: field.valorInicial,
              hintText: field.hintText,
              width: MediaQuery.of(context).size.width,
              hasDate: field.hasDate,
            ),
          ),
        );
      } else {
        tempRow.add(
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
            child: CustomInputForm(
              valorInicial: field.valorInicial,
              label: field.label,
              hintText: field.hintText,
              width: MediaQuery.of(context).size.width * 0.45,
              hasDate: field.hasDate,
            ),
          ),
        );
        if (tempRow.length == 2) {
          rows.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: tempRow,
            ),
          );
          tempRow = [];
        }
      }
    }

    if (tempRow.isNotEmpty) {
      rows.add(Row(children: tempRow));
    }

    return rows;
  }
}

class CustomInputForm extends StatelessWidget {
  final String label;
  final String hintText;
  final String? valorInicial;
  final String? data;
  final String? subtopico;
  final double width;
  final bool hasDate;

  const CustomInputForm({
    super.key,
    required this.label,
    required this.hintText,
    this.valorInicial,
    this.data,
    this.subtopico,
    required this.width,
    this.hasDate = false,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Container(
      width: width,
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   label,
          //   style: const TextStyle(
          //     fontWeight: FontWeight.bold,
          //     color: verde1,
          //   ),
          // ),
          const SizedBox(height: 8),
          TextFieldCustom(
            labelText: label,
            valorInicial: valorInicial,
            senha: false,
            tipoTexto: TextInputType.text,
            hintText: hintText,
          ),
          if (subtopico != null)
            Text(subtopico!,
                style: const TextStyle(
                  color: preto1,
                  fontSize: 12,
                )),
          if (data != null)
            Row(
              children: [
                const Icon(Icons.date_range, color: preto1),
                Text(data!,
                    style: const TextStyle(
                      color: preto1,
                      fontSize: 12,
                    )),
              ],
            ),
          // TextField(
          //   decoration: InputDecoration(
          //     hintText: hintText,
          //     border: const OutlineInputBorder(),
          //     filled: true,
          //     fillColor: background,
          //   ),
          // ),
          if (hasDate)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Data de registro: $formattedDate',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class DoubleHeightInput extends StatelessWidget {
  final String label;
  final String hintText;
  final String? subtopico;
  final String? data;
  final String? valorInicial;
  final double width;
  final bool hasDate;

  const DoubleHeightInput({
    super.key,
    required this.label,
    required this.hintText,
    this.subtopico,
    this.data,
    this.valorInicial,
    required this.width,
    this.hasDate = false,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Container(
      width: width,
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   label,
          //   style: const TextStyle(
          //     fontWeight: FontWeight.bold,
          //     color: verde1,
          //   ),
          // ),
          const SizedBox(height: 8),
          TextFieldCustom(
            labelText: label,
            valorInicial: valorInicial,
            senha: false,
            tipoTexto: TextInputType.text,
            hintText: hintText,
          ),
          if (subtopico != null)
            Text(subtopico!,
                style: const TextStyle(
                  color: preto1,
                  fontSize: 12,
                )),
          if (data != null)
            Row(
              children: [
                const Icon(Icons.date_range, color: preto1),
                Text(data!,
                    style: const TextStyle(
                      color: preto1,
                      fontSize: 12,
                    )),
              ],
            ),

          if (hasDate)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Data de registro: $formattedDate',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class RadioField extends StatefulWidget {
  final String label;
  final String value;

  const RadioField({super.key, required this.label, required this.value});

  @override
  _RadioFieldState createState() => _RadioFieldState();
}

class _RadioFieldState extends State<RadioField> {
  String? _curatelado;

  @override
  void initState() {
    super.initState();
    _curatelado = widget.value; // Inicializa o estado com o valor recebido
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.bold, color: preto1),
          ),
          Row(
            children: [
              Radio<String>(
                value: 'Sim',
                groupValue: _curatelado,
                onChanged: (value) {
                  setState(() {
                    _curatelado = value;
                  });
                },
                activeColor: verde1,
              ),
              const Text("Sim"),
              Radio<String>(
                value: 'Não',
                groupValue: _curatelado,
                onChanged: (value) {
                  setState(() {
                    _curatelado = value;
                  });
                },
                activeColor: verde1,
              ),
              const Text("Não"),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageField extends StatelessWidget {
  final String label;
  final List<String>? images;
  final void Function()? onTapContainer;

  const ImageField({super.key, required this.label, this.images, this.onTapContainer});

  @override
  Widget build(BuildContext context) {
      final imagesLista = context.watch<ImageProviderCustom>().images;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: verde1,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (images != null)
              ...images!.map((image) => Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    height: MediaQuery.of(context).size.width * 0.22,
                    color: Colors.grey[300],
                    child: Image.network(image, fit: BoxFit.cover),
                  )),
            if (imagesLista != null)
              ...imagesLista.map((image) => Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    height: MediaQuery.of(context).size.width * 0.22,
                    color: Colors.grey[300],
                    child: Image.memory(image, fit: BoxFit.cover),
                  )),
            if ((images?.length ?? 0) + (imagesLista?.length ?? 0) < 3)
              InkWell(
                onTap: onTapContainer,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: MediaQuery.of(context).size.width * 0.22,
                  color: Colors.grey[300],
                  child: const Icon(Icons.add_a_photo),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
