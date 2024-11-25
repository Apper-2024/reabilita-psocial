import 'package:flutter/material.dart';
import 'package:reabilita_social/widgets/card_projeto.dart';
import '../utils/colors.dart';
import '../widgets/header.dart';

class ProjetoScreen extends StatelessWidget {
  const ProjetoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(
                imageUrl:
                    'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                notificationCount: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tenha acesso aos projetos criados',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: preto1,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Procure o nome do paciente',
                  hintStyle: const TextStyle(color: cinza1, fontSize: 18),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.search, color: cinza1),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: background, width: 2.0),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: cinza1, width: 2.0),
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 16),
              const CardProjeto(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text(
            'Adicionar Projeto',
            style: TextStyle(color: background),
          ),
          icon: const Icon(Icons.add, color: background),
          backgroundColor: verde1),
    );
  }
}
