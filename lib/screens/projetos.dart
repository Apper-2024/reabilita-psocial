import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_projeto.dart';
import 'package:reabilita_social/widgets/header.dart';
import 'package:reabilita_social/widgets/inputText/text_search.dart';


class ProjetosScreen extends StatefulWidget {
  const ProjetosScreen({super.key});

  @override
  _ProjetosScreenState createState() => _ProjetosScreenState();
}

class _ProjetosScreenState extends State<ProjetosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                imageUrl:
                    'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                notificationCount: 3,
              ),
              SizedBox(height: 16),
              Text(
                'Tenha acesso aos projetos criados',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: preto1,
                ),
              ),
              SizedBox(height: 16),
              TextSearch(hintText: 'Procure o nome do paciente'),
              
              SizedBox(height: 16),
              CardProjeto(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Navigator.pushNamed(context, '/cadastroProjeto');
          },
          label: const Text(
            'Adicionar Projeto',
            style: TextStyle(color: background),
          ),
          icon: const Icon(Icons.add, color: background),
          backgroundColor: verde1),
    );
  }
}
