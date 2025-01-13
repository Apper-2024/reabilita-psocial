import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';

class NaoEncontrado extends StatefulWidget {
  final String titulo;
  final String? textButton;
  final void Function()? onPressed;

  const NaoEncontrado({
    super.key,
    required this.titulo,
    this.textButton,
    this.onPressed,
  }) : assert(onPressed == null || textButton != null, 'textButton deve ser fornecido quando onPressed não for nulo');

  @override
  _NaoEncontradoState createState() => _NaoEncontradoState();
}

class _NaoEncontradoState extends State<NaoEncontrado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.titulo, style: const TextStyle(fontSize: 20, color: preto1)),
              Visibility(
                visible: widget.onPressed != null && widget.textButton != null,
                child: Botaoprincipal(
                  text: widget.textButton ?? '',
                  onPressed: widget.onPressed ?? () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
