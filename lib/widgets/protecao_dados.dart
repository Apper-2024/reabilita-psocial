import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class ProtecaoDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text(
            "Proteção e Visibilidade de Dados",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: const SingleChildScrollView(
            child: Text(
              "Respeitamos sua privacidade e estamos comprometidos com a proteção dos seus dados pessoais. "
              "As informações fornecidas durante o uso do aplicativo são coletadas e utilizadas para garantir uma melhor experiência, "
              "incluindo funcionalidades personalizadas e aprimoramento contínuo dos nossos serviços.\n\n"
              "Todos os dados coletados são tratados de acordo com as legislações vigentes de proteção de dados (LGPD) e serão armazenados "
              "de forma segura, sendo acessíveis apenas a equipes autorizadas e para os fins informados. "
              "Os dados não serão compartilhados com terceiros sem seu consentimento explícito, exceto em casos exigidos por lei.\n\n"
              "Ao continuar utilizando este aplicativo, você concorda com nossa política de uso e proteção de dados. Para mais informações, "
              "entre em contato com nossa equipe de suporte.",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Fechar",
                style: TextStyle(
                  color: verde1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
