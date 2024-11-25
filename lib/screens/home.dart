import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/header.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
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
              const Align(
                alignment: Alignment.centerLeft,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bem-Vindo,',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Beatriz!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ferramentas de auxílio',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  color: AppColors.preto1,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.bege,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Suporte ao Usuário',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: AppColors.preto1,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Referências, legislações,\ninformações e muito mais',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: AppColors.preto1,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Conferir  ➔',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AppColors.verde1,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.flag, color: AppColors.preto1, size: 48),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 8),
                    Expanded(
                      child: const Text(
                        '“Permeando projetos de vida com sentidos e significados construídos no habitat, rede social e trabalho”',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: AppColors.cinza1,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.format_quote,
                      color: AppColors.bege,
                      size: 48,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Reabilitação Psicossocial',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  color: AppColors.preto1,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 120,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.verde1,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Como realizar um Projeto\nde Reabilitação Psicossocial?',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.spa, color: AppColors.verde2, size: 58),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
