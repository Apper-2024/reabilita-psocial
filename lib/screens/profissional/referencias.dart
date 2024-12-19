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
          ],
        ),
      ),
    );
  }
}
