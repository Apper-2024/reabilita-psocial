import 'package:flutter/material.dart';

class ListaOpcao extends StatefulWidget {
  ListaOpcao({super.key});

  @override
  State<ListaOpcao> createState() => _ListaOpcaoState();
}

class _ListaOpcaoState extends State<ListaOpcao> {
  String? _opcaoSelecionada;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Avaliação',
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: Radio<String>(
            value: 'totalmente',
            groupValue: _opcaoSelecionada,
            onChanged: (String? value) {
              setState(() {
                _opcaoSelecionada = value;
              });
            },
            activeColor: Colors.green,
          ),
          title: Text(
            'Cumpriu totalmente',
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: Radio<String>(
            value: 'parcialmente',
            groupValue: _opcaoSelecionada,
            onChanged: (String? value) {
              setState(() {
                _opcaoSelecionada = value;
              });
            },
            activeColor: Colors.green,
          ),
          title: Text(
            'Cumpriu parcialmente',
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: Radio<String>(
            value: 'nao',
            groupValue: _opcaoSelecionada,
            onChanged: (String? value) {
              setState(() {
                _opcaoSelecionada = value;
              });
            },
            activeColor: Colors.green,
          ),
          title: Text(
            'Não cumpriu',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }
}
