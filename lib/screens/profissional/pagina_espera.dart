import 'package:flutter/material.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/screens/video.dart';
import '../../utils/colors.dart';
import '../../widgets/header.dart';

class PaginaEsperaScreen extends StatefulWidget {
  const PaginaEsperaScreen({super.key});

  @override
  _PaginaEsperaScreenState createState() => _PaginaEsperaScreenState();
}

class _PaginaEsperaScreenState extends State<PaginaEsperaScreen> {
  ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: profissionalProvider.profissional?.nome == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cabeçalho
                    Header(),
                    const SizedBox(height: 16),

                    // Boas-vindas
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bem-vindo,',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.normal,
                              color: preto1,
                            ),
                          ),
                          Text(
                            "${profissionalProvider.profissional!.nome}!",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: preto1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    Center(
                        child: Text(
                      "Aguarde a aprovação da sua conta para começar a utilizar o aplicativo.",
                      style: TextStyle(fontSize: 16, color: preto1),
                    )),
                  ],
                ),
              ),
            ),
    );
  }
}
