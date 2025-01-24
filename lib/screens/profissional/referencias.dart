import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_ajuda.dart';

class ReferenciasPage extends StatelessWidget {
  const ReferenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          "Referências",
          style: TextStyle(
            color: verde1,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: background,
        iconTheme: const IconThemeData(color: verde1),
        centerTitle: true,
        elevation: 0, // Remove sombra
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            CardAjuda(
              titulo: "BABINSKI, T.; HIRDES, A.",
              descricacao:
                  "Reabilitação psicossocial: a perspectiva de profissionais de centros de atenção psicossocial do Rio Grande do Sul. Texto & Contexto - Enfermagem, v. 13, n. 4, p. 568-576, dez. 2004.",
            ),
            CardAjuda(
              titulo: "Campos FAAC et al.",
              descricacao:
                  "Reabilitação Psicossocial: O Relato de Um Caso na Amazônia. Saúde em Redes. 2021; 7(supl.2):1-18",
            ),
            CardAjuda(
              titulo: "HIRDES, A.; KANTORSKI, L. P.",
              descricacao:
                  "Reabilitação psicossocial: objetivos, princípios e valores. R Enferm UERJ, v. 12, p. 217-221, 2004.",
            ),
            CardAjuda(
              titulo: "PITTA, A.",
              descricacao:
                  "Reabilitação Psicossocial no Brasil. São Paulo: Hucitec, 2016.",
            ),
            CardAjuda(
              titulo: "SARACENO, B.",
              descricacao:
                  "Libertando identidades da reabilitação psicossocial e cidadania possível. Belo Horizonte/Rio de Janeiro: Te Corá Editora/Instituto Franco Basaglia, 2001.",
            ),
            CardAjuda(
              titulo: "Sanches LR, Vecchia MD",
              descricacao:
                  "Reabilitação Psicossocial e Reinserção Social de usuários de drogas: revisão de literatura. Psicol Soc. 2018;30:e178335.",
            ),
            CardAjuda(
              titulo: "Moura AA, Cartaxo CMB, Mendonça MCA",
              descricacao:
                  "“Se é para jogar dominó, eu jogo em casa”: reflexões sobre a ociosidade em serviços de saúde mental. Cad Bras Saúde Ment. 2023;15(42):106–28.",
            ),
            CardAjuda(
              titulo: "Araújo JB, Cassoli T. ",
              descricacao:
                  "Reabilitação psicossocial: entre a segurança e ética da existência. Rev. polis psique. 2020 Out;10(3):52-76.",
            ),
            CardAjuda(
              titulo: "Guerra AMC.",
              descricacao:
                  "Reabilitação psicossocial no campo da reforma psiquiátrica: uma reflexão sobre o controverso conceito e seus possíveis paradigmas. Rev Latinoam Psicopat Fund. 2004;7(2):1–14.",
            ),
            CardAjuda(
              titulo: "Babinski T, Hirdes A.",
              descricacao:
                  "Reabilitação psicossocial: a perspectiva de profissionais de centros de atenção psicossocial do Rio Grande do Sul. Texto contexto – enferm. 2004;13(4):568–76. ",
            ),
            CardAjuda(
              titulo: "Silva PE, Ronsoni EÂ.",
              descricacao:
                  "Educação Popular em Saúde e a promoção de reabilitação psicossocial: relato de experiência de um grupo em um CAPS AD. Rev Ed Popular. 2022 Ago;21(2):307-26.",
            ),
            CardAjuda(
              titulo: "Lussi IAO, Pereira MAO, Pereira Junior A. ",
              descricacao:
                  "A proposta de reabilitação psicossocial de Saraceno: um modelo de auto-organização? Rev Latino-Am Enfermagem. 2006;14(3):448–56.",
            ),
            CardAjuda(
              titulo: "Mendes L, Ramos L, Nicolau C, José S.",
              descricacao:
                  "Intervenções de enfermagem promotoras de esperança na reabilitação psicossocial orientada para o Recovery: revisão integrativa da literatura. Rev Portuguesa Enferm Saúde Mental. 2022 Jul;(28):197-209.",
            ),
          ],
        ),
      ),
    );
  }
}
