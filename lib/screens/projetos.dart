import 'package:flutter/material.dart';
import 'package:reabilita_social/widgets/card_projeto.dart';
import '../utils/colors.dart';
import '../widgets/header.dart';

class ProjetoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
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
                  color: AppColors.preto1,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Procure o nome do paciente',
                  hintStyle:
                      const TextStyle(color: AppColors.cinza1, fontSize: 18),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: const Icon(Icons.search, color: AppColors.cinza1),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.background, width: 2.0),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.cinza1, width: 2.0),
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 16),
              CardProjeto(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            'Adicionar Projeto',
            style: TextStyle(color: AppColors.background),
          ),
          icon: Icon(Icons.add, color: AppColors.background),
          backgroundColor: AppColors.verde1),
    );
  }
}
