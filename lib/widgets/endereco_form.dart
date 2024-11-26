import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/formaters/formater_data.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';
import 'package:http/http.dart' as http;

class EnderecoForm extends StatefulWidget {
  final String titulo;
  final Function(String) onCepSaved;
  final Function(String) onRuaSaved;
  final Function(String) onBairroSaved;
  final Function(String) onCidadeSaved;
  final Function(String) onEstadoSaved;
  final Function(String) onComplementoSaved;
  final Function(String) onNumeroSaved;
  final String? valorInicialCep;
  final String? valorInicialRua;
  final String? valorInicialBairro;
  final String? valorInicialCidade;
  final String? valorInicialEstado;
  final String? valorInicialComplemento;
  final String? valorInicialNumero;

  const EnderecoForm({
    super.key,
    required this.titulo,
    required this.onCepSaved,
    required this.onRuaSaved,
    required this.onBairroSaved,
    required this.onCidadeSaved,
    required this.onEstadoSaved,
    required this.onComplementoSaved,
    required this.onNumeroSaved,
    this.valorInicialCep,
    this.valorInicialRua,
    this.valorInicialBairro,
    this.valorInicialCidade,
    this.valorInicialEstado,
    this.valorInicialComplemento,
    this.valorInicialNumero,
  });
  @override
  _EnderecoFormState createState() => _EnderecoFormState();
}

class _EnderecoFormState extends State<EnderecoForm> {
  late TextEditingController ruaController;
  late TextEditingController bairroController;
  late TextEditingController cidadeController;
  late TextEditingController estadoController;

  @override
  void initState() {
    super.initState();
    ruaController = TextEditingController(text: widget.valorInicialRua);
    bairroController = TextEditingController(text: widget.valorInicialBairro);
    cidadeController = TextEditingController(text: widget.valorInicialCidade);
    estadoController = TextEditingController(text: widget.valorInicialEstado);
  }

  @override
  void dispose() {
    ruaController.dispose();
    bairroController.dispose();
    cidadeController.dispose();
    estadoController.dispose();
    super.dispose();
  }

  Future<void> buscarCep(String cep) async {
    String url = "https://viacep.com.br/ws/$cep/json/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> dados = json.decode(response.body);

        String cidade = dados["localidade"];
        String bairro = dados["bairro"];
        String endereco = dados["logradouro"];
        String estado = dados["uf"];

        setState(() {
          ruaController.text = endereco;
          bairroController.text = bairro;
          estadoController.text = estado;
          cidadeController.text = cidade;
        });
      } else {
        print("Erro na solicitação HTTP: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro durante a solicitação HTTP: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titulo,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: preto1,
          ),
        ),
        const SizedBox(height: 12),
        TextFieldCustom(
          hintText: '00000-000',
          tipoTexto: TextInputType.number,
          labelText: "CEP",
          valorInicial: widget.valorInicialCep,
          inputFormatters: [cepFormater],
          onSaved: (value) {
            widget.onCepSaved(value!);
          },
          onChanged: (value) {
            if (value.length == 9) {
              buscarCep(value);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Este campo é obrigatório!";
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        TextFieldCustom(
          hintText: "Rua jose da silva",
          labelText: "Rua",
          tipoTexto: TextInputType.streetAddress,
          formController: ruaController,
          onSaved: (value) {
            widget.onRuaSaved(value!);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Este campo é obrigatório!";
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        TextFieldCustom(
          hintText: 'Joaquim ',
          formController: bairroController,
          labelText: "Bairro",
          tipoTexto: TextInputType.text,
          onSaved: (value) {
            widget.onBairroSaved(value!);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Este campo é obrigatório!";
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        TextFieldCustom(
          hintText: 'São Paulo',
          formController: cidadeController,
          labelText: "Cidade",
          tipoTexto: TextInputType.text,
          onSaved: (value) {
            widget.onCidadeSaved(value!);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Este campo é obrigatório!";
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        TextFieldCustom(
          hintText: 'SP',
          formController: estadoController,
          labelText: "Estado",
          tipoTexto: TextInputType.text,
          onSaved: (value) {
            widget.onEstadoSaved(value!);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Este campo é obrigatório!";
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        TextFieldCustom(
          hintText: 'Apto 101',
          labelText: "Complemento",
          valorInicial: widget.valorInicialComplemento,
          tipoTexto: TextInputType.text,
          onSaved: (value) {
            widget.onComplementoSaved(value!);
          },
        ),
        const SizedBox(height: 12),
        TextFieldCustom(
          hintText: '101',
          labelText: "Número",
          tipoTexto: TextInputType.number,
          valorInicial: widget.valorInicialNumero,
          onSaved: (value) {
            widget.onNumeroSaved(value!);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Este campo é obrigatório!";
            }
            return null;
          },
        ),
      ],
    );
  }
}
