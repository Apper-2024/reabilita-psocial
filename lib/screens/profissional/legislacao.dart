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
        title: Text(
          "Legislação em Saúde Mental",
          style: TextStyle(
            color: verde1, 
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: background,
        iconTheme: IconThemeData(color: verde1), 
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
          ],
        ),
      ),
    );
  }
}
