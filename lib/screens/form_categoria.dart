import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reabilita_social/utils/colors.dart';

class FieldConfig {
  final String label;
  final String hintText;
  final double widthFactor;
  final bool isDoubleHeight;
  final bool hasDate;
  final bool isRadioField;
  final bool isImageField;
  final List<ImageProvider>? images;

  FieldConfig({
    required this.label,
    required this.hintText,
    this.widthFactor = 1.0,
    this.isDoubleHeight = false,
    this.hasDate = false,
    this.isRadioField = false,
    this.isImageField = false,
    this.images,
  });
}

class FormCategoria extends StatelessWidget {
  final String titulo;
  final List<FieldConfig> fields;

  const FormCategoria({
    Key? key,
    required this.titulo,
    required this.fields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: _buildFieldRows(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFieldRows(BuildContext context) {
    List<Widget> rows = [];
    List<Widget> tempRow = [];

    for (var field in fields) {
      if (field.isImageField) {
        if (tempRow.isNotEmpty) {
          rows.add(Row(children: tempRow));
          tempRow = [];
        }
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ImageField(label: field.label, images: field.images),
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
            child: RadioField(label: field.label),
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
              label: field.label,
              hintText: field.hintText,
              width: MediaQuery.of(context).size.width,
              hasDate: field.hasDate,
            ),
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
              label: field.label,
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
  final double width;
  final bool hasDate;

  const CustomInputForm({
    Key? key,
    required this.label,
    required this.hintText,
    required this.width,
    this.hasDate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Container(
      width: width,
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.verde1,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: AppColors.background,
            ),
          ),
          if (hasDate)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Data de registro: $formattedDate',
                style: TextStyle(color: Colors.grey, fontSize: 12),
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
  final double width;
  final bool hasDate;

  const DoubleHeightInput({
    Key? key,
    required this.label,
    required this.hintText,
    required this.width,
    this.hasDate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Container(
      width: width,
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.verde1,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: AppColors.background,
            ),
          ),
          if (hasDate)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Data de registro: $formattedDate',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class RadioField extends StatefulWidget {
  final String label;

  const RadioField({Key? key, required this.label}) : super(key: key);

  @override
  _RadioFieldState createState() => _RadioFieldState();
}

class _RadioFieldState extends State<RadioField> {
  String? _curatelado;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: AppColors.preto1),
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
                activeColor: AppColors.verde1,
              ),
              Text("Sim"),
              Radio<String>(
                value: 'Não',
                groupValue: _curatelado,
                onChanged: (value) {
                  setState(() {
                    _curatelado = value;
                  });
                },
                activeColor: AppColors.verde1,
              ),
              Text("Não"),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageField extends StatelessWidget {
  final String label;
  final List<ImageProvider>? images;

  const ImageField({Key? key, required this.label, this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.verde1,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.width * 0.22,
              color: Colors.grey[300],
              child: images != null && index < images!.length
                  ? Image(image: images![index], fit: BoxFit.cover)
                  : Icon(Icons.image, color: Colors.grey[600]),
            );
          }),
        ),
      ],
    );
  }
}
