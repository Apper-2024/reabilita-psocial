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
  final bool umaImagem;
  final bool isDropdownField;
  final List<String>? images;
  final String? imagem;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onChangedDropdown;
  final String? subtopico;
  final String? data;
  final void Function()? onTapContainer;
  final bool isButtonField;
  final String? textBotao;
  final bool botaoAdicionar;
  final void Function()? onTapbotaoAdicionar;
  final void Function()? onTapBotao;
  final int? maxLine;
  final int? minLine;
  final TextEditingController? controller;
  final ValueChanged<String?>? onChangedRadio;
  final bool carregando;
  final bool iconEdit;
  final void Function()? onTapIconEdit;
  final void Function(String)? onDeleteImage;

  FieldConfig({
    required this.label,
    required this.hintText,
    this.valorInicial,
    this.widthFactor = 1.0,
    this.isDoubleHeight = false,
    this.hasDate = false,
    this.isRadioField = false,
    this.isImageField = false,
    this.umaImagem = false,
    this.isDropdownField = false,
    this.images,
    this.imagem,
    this.dropdownItems,
    this.onChangedDropdown,
    this.subtopico,
    this.data,
    this.onTapContainer,
    this.isButtonField = false,
    this.textBotao,
    this.botaoAdicionar = false,
    this.onTapbotaoAdicionar,
    this.onTapBotao,
    this.maxLine,
    this.minLine,
    this.onChangedRadio,
    this.carregando = false,
    this.iconEdit = false,
    this.onTapIconEdit,
    this.onDeleteImage,
  }) : controller = TextEditingController(text: valorInicial);
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
  FormCategoriaState createState() => FormCategoriaState();
}

class FormCategoriaState extends State<FormCategoria> {
  @override
  void dispose() {
    for (var field in widget.fields) {
      field.controller?.dispose();
    }
    super.dispose();
  }

  Map<String, String> getFormValues() {
    Map<String, String> formValues = {};
    for (var field in widget.fields) {
      formValues[field.label] = field.controller!.text;
    }
    return formValues;
  }

  List<String> getFormValuesList() {
    List<String> formValues = [];
    for (var field in widget.fields) {
      formValues.add(field.controller!.text);
    }
    return formValues;
  }

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

    for (int i = 0; i < widget.fields.length; i++) {
      final field = widget.fields[i];

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
              onDeleteImage: field.onDeleteImage as void Function(String)?,
            ),
          ),
        );
      } else if (field.umaImagem) {
        if (tempRow.isNotEmpty) {
          rows.add(Row(children: tempRow));
          tempRow = [];
        }
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ImageField2(
              label: field.label,
              image: field.imagem,
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
            child: RadioField(
              label: field.label,
              value: field.hintText,
              onChangedRadio: field.onChangedRadio,
            ),
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
                dropdownValue: field.hintText,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: DoubleHeightInput(
                    data: field.data,
                    subtopico: field.subtopico,
                    label: field.label,
                    hintText: field.hintText,
                    width: MediaQuery.of(context).size.width,
                    hasDate: field.hasDate,
                    maxLines: field.maxLine,
                    minLines: field.minLine,
                    controller: field.controller,
                  ),
                ),
                SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                      visible: field.iconEdit,
                      child: Center(child: IconButton(onPressed: field.onTapIconEdit, icon: Icon(Icons.edit)))),
                ),
              ],
            ),
          ),
        );
        if (field.botaoAdicionar) {
          if (i == widget.fields.length - 1 || !widget.fields[i + 1].isDoubleHeight) {
            rows.add(
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: Botaoprincipal(
                    onPressed: field.onTapbotaoAdicionar!,
                    text: 'Criar novo',
                  ),
                ),
              ),
            );
          }
        }
      } else if (field.isButtonField) {
        if (tempRow.isNotEmpty) {
          rows.add(Row(children: tempRow));
          tempRow = [];
        }
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
            child: Botaoprincipal(text: field.textBotao!, onPressed: field.onTapBotao!, carregando: field.carregando),
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
              hintText: field.hintText,
              width: MediaQuery.of(context).size.width,
              hasDate: field.hasDate,
              controller: field.controller,
            ),
          ),
        );
      } else {
        tempRow.add(
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
            child: CustomInputForm(
              label: field.label,
              hintText: field.hintText,
              width: MediaQuery.of(context).size.width * 0.45,
              hasDate: field.hasDate,
              controller: field.controller,
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
  final TextEditingController? controller;
  const CustomInputForm({
    super.key,
    required this.label,
    required this.hintText,
    this.valorInicial,
    this.data,
    this.subtopico,
    required this.width,
    this.hasDate = false,
    this.controller,
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
            formController: controller,
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
  final int? maxLines;
  final int? minLines;
  final TextEditingController? controller;
  const DoubleHeightInput({
    super.key,
    required this.label,
    required this.hintText,
    this.subtopico,
    this.data,
    this.valorInicial,
    required this.width,
    this.hasDate = false,
    this.maxLines,
    this.minLines,
    this.controller,
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
            maxLines: maxLines,
            minLines: minLines,
            formController: controller,
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
  final ValueChanged<String?>? onChangedRadio;
  const RadioField({super.key, required this.label, required this.value, this.onChangedRadio});

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
                    widget.onChangedRadio?.call(value);
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
                    widget.onChangedRadio?.call(value);
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
  final void Function(String)? onDeleteImage;

  const ImageField({super.key, required this.label, this.images, this.onTapContainer, this.onDeleteImage});

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
              ...images!.map((image) => Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.width * 0.22,
                        color: Colors.grey[300],
                        child: Image.network(image, fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () => onDeleteImage?.call(image),
                          child: Container(
                            color: Colors.black54,
                            child: const Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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

class ImageField2 extends StatelessWidget {
  final String label;
  final String? image;
  final void Function()? onTapContainer;

  const ImageField2({super.key, required this.label, this.image, this.onTapContainer});

  @override
  Widget build(BuildContext context) {
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
        Container(
          width: MediaQuery.of(context).size.width * 0.22,
          height: MediaQuery.of(context).size.width * 0.22,
          color: Colors.grey[300],
          child: Image.network(image!, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
