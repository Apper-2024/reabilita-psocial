import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class InformacaoTecnica extends StatelessWidget {
  const InformacaoTecnica({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: verde2,
        title: const Text('Informação Técnica',
            style: TextStyle(fontFamily: 'Poppins')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INFORMAÇÃO TÉCNICA:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Dúvidas, sugestões e problemas técnicos:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.blueGrey),
                  SizedBox(width: 10),
                  Text(
                    'fagneralfredo@hotmail.com',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.blueGrey),
                  SizedBox(width: 10),
                  Text(
                    'g.lamarca@outlook.com',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.blueGrey),
                  SizedBox(width: 10),
                  Text(
                    'joaoantonio@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Produto Tecnológico fruto da Tese de Doutorado: "A construção e validação de um aplicativo virtual para elaboração, acompanhamento e avaliação de projetos de reabilitação psicossocial em saúde mental". Disponível na Biblioteca Digital de Teses e Dissertações da USP.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blueGrey),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Para mais informações, entre em contato pelo e-mail informado acima.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
