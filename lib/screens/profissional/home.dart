import 'package:flutter/material.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/screens/video.dart';
import '../../utils/colors.dart';
import '../../widgets/header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;

  void _showVideoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        insetPadding: const EdgeInsets.all(16.0),
        child: const VideoPlayerWidget(videoPath: 'assets/video/PRP.mp4'),
      ),
    );
  }

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

                    // Ferramentas de auxílio
                    const Text(
                      'Ferramentas de auxílio',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: preto1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Suporte ao Usuário
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/suporteUsuario");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: bege,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Suporte ao Usuário',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      color: preto1,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Referências, legislações, informações e muito mais',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: preto1,
                                    ),
                                    softWrap: true,
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
                            ),
                            Icon(Icons.flag, color: verde1, size: 48),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Citação
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.format_quote,
                            color: bege,
                            size: 48,
                          ),
                          SizedBox(width: 16),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Assista o Vídeo Sobre Projeto de Reabilitação Psicossocial',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: preto1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    //imagens nao achando
                    InkWell(
                      onTap: () => _showVideoDialog(context),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: AssetImage('assets/imagens/thumb.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            child: Icon(
                              Icons.play_circle_filled,
                              size: 58,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Dicas de Reabilitação Psicossocial',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: preto1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '• Estimule a autonomia do paciente com atividades diárias.\n• Incentive a participação em redes sociais de apoio.\n• Estabeleça metas mensuráveis e significativas para o paciente.\n• Mantenha o diálogo transversal com os familiares e profissionais envolvidos.',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: cinza1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
