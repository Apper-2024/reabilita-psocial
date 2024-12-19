import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/profissional/legislacao.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_opcao.dart';
import 'referencias.dart';

class SuporteUsuario extends StatelessWidget {
  const SuporteUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          "Suporte ao Usuário",
        ),
        backgroundColor: background,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            OpcaoCard(
              icon: Icons.healing,
              title: "REFERÊNCIAS EM REABILITAÇÃO PSICOSSOCIAL",
              destination: ReferenciasPage(),
            ),
            OpcaoCard(
              icon: Icons.gavel,
              title: "LEGISLAÇÃO EM SAÚDE MENTAL E ASSISTÊNCIA SOCIAL",
              destination: LegislacaoPage(),
            ),
            // OpcaoCard(
            //   icon: Icons.search,
            //   title: "BUSCA DE SERVIÇOS DE SAÚDE MENTAL",
            //   destination: BuscaServicosPage(),
            // ),
            // OpcaoCard(
            //   icon: Icons.bar_chart,
            //   title: "RELATÓRIO E ESTATÍSTICAS",
            //   destination: ReportsPage(),
            // ),
            // OpcaoCard(
            //   icon: Icons.info,
            //   title: "INFORMAÇÃO TÉCNICA",
            //   destination: TechnicalInfoPage(),
            // ),
            // OpcaoCard(
            //   icon: Icons.developer_mode,
            //   title: "DESENVOLVEDORES",
            //   destination: DevelopersPage(),
            // ),
            // OpcaoCard(
            //   icon: Icons.thumb_up,
            //   title: "AGRADECIMENTOS",
            //   destination: AcknowledgementsPage(),
            // ),
          ],
        ),
      ),
    );
  }
}

