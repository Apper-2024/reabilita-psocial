import 'package:flutter/material.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import '../../utils/colors.dart';
import '../../widgets/header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: profissionalProvider.profissional?.nome == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(
                      // imageUrl: profissionalProvider.profissional!.urlFoto,
                      notificationCount: 4,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bem-Vindo,',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            profissionalProvider.profissional!.nome,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Ferramentas de auxílio',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: preto1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: bege,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Suporte ao Usuário',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: preto1,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Referências, legislações,\ninformações e muito mais',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  color: preto1,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Conferir  ➔',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: verde1,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.flag, color: preto1, size: 48),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '“Permeando projetos de vida com sentidos e significados construídos no habitat, rede social e trabalho”',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: cinza1,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.format_quote,
                            color: bege,
                            size: 48,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Reabilitação Psicossocial',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: preto1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 120,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: verde1,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Como realizar um Projeto\nde Reabilitação Psicossocial?',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Icon(Icons.spa, color: verde2, size: 58),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
