import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_ajuda.dart';

class LegislacaoPage extends StatelessWidget {
  const LegislacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          "Legislação em Saúde Mental",
          style: TextStyle(
            color: verde1,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: background,
        iconTheme: const IconThemeData(color: verde1),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            CardAjuda(
              titulo: "Lei nº 10.216",
              descricacao: "De 6 de abril de 2001 (Reforma Psiquiátrica)",
            ),
            CardAjuda(
              titulo: "Portaria GMS nº 336",
              descricacao: "De 19 de fevereiro de 2002 (Serviços CAPS)",
            ),
            CardAjuda(
              titulo: "Portaria GMS nº 130",
              descricacao: "De 26 de janeiro de 2002 (Serviço CAPS AD III)",
            ),
            CardAjuda(
              titulo: "Portaria GMS nº 122",
              descricacao: "De 25 de janeiro de 2011 (Consultório na Rua)",
            ),
            CardAjuda(
              titulo: "Portaria GMS nº 121",
              descricacao:
                  "De 25 de janeiro de 2012 (Unidade de Acolhimento para Usuários de Álcool e Outras Drogas)",
            ),
            CardAjuda(
              titulo: "Portaria GMS nº 16",
              descricacao:
                  "De 11 de fevereiro de 2000 (Residências Terapêuticas)",
            ),
            CardAjuda(
              titulo: "Portaria GMS nº 3088",
              descricacao:
                  "De 23 de dezembro de 2011 (Rede de Atenção Psicossocial)",
            ),
            CardAjuda(
              titulo: "Portaria nº 1.059",
              descricacao: "De 04 de julho de 2005 (Redução de Danos)",
            ),
            CardAjuda(
              titulo:
                  "Portaria GMS n. 130, de 26 de janeiro de 2012 (Específica para CAPS III).",
              descricacao:
                  "Redefine o Centro de Atenção Psicossocial de Álcool e outras Drogas 24 h (CAPS AD III) e os respectivos incentivos financeiros.",
            ),
            CardAjuda(
              titulo: "Portaria GMS n. 3.588, de 21 de dezembro de 2017. ",
              descricacao:
                  "Dispõe sobre o funcionamento do CAPS AD IV, Equipe Multiprofissional de Atenção Especializada em Saúde Mental",
            ),
            CardAjuda(
                titulo:
                    "Portaria GMS n. 121, de 25 de janeiro de 2012 (Unidade de Acolhimento para Usuário de Álcool e Outras Drogas).",
                descricacao:
                    "Estabelece que os Serviços Residenciais Terapêuticos (SRTs), sejam definidos em tipo I e II, destina recurso financeiro para incentivo e custeio dos SRTs, e dá outras providências. A Portaria GMS n. 3.588, de 21 de dezembro de 2017 traz anexo específico sobre funcionamento das Residências Terapêuticas (Ver link: https://bvsms.saude.gov.br/bvs/saudelegis/gm/2017/prt3588_22_12_2017.html)."),
            CardAjuda(
              titulo:
                  "Portaria GMS n. 148, de 31 de janeiro de 2012 (Leitos de Saúde Mental e Hospitais de Referências).",
              descricacao:
                  "Define as normas de funcionamento e habilitação do Serviço Hospitalar de Referência para atenção a pessoas com sofrimento ou transtorno mental e com necessidades de saúde decorrentes do uso de álcool, crack e outras drogas, do Componente Hospitalar da Rede de Atenção Psicossocial, e institui incentivos financeiros de investimento e de custeio.",
            ),
            CardAjuda(
              titulo:
                  "PORTARIA GMS n. 251/GM, de 31 de janeiro de 2002 (Hospital Psiquiátrico). ",
              descricacao:
                  "Estabelece diretrizes e normas para a assistência hospitalar em psiquiatria, reclassifica os hospitais psiquiátricos, define e estrutura, a porta de entrada para as internações psiquiátricas na rede do SUS.",
            ),
            CardAjuda(
              titulo:
                  "Portaria GMS n. 44, de 10 de janeiro de 2001 (Hospital-Dia).",
              descricacao:
                  "Dispõe sobre o funcionamento de hospitais dias, incluído para saúde mental ",
            ),
          ],
        ),
      ),
    );
  }
}
