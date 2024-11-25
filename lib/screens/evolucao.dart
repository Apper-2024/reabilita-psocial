import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/evolucao_paciente.dart';
import 'package:reabilita_social/widgets/card_evolu%C3%A7%C3%A3o.dart';
import 'package:reabilita_social/widgets/card_projeto.dart';
import '../utils/colors.dart';
import '../widgets/header.dart';

void main() {
  runApp(MaterialApp(
    home: EvolucaoScreen(),
  ));
}

class EvolucaoScreen extends StatelessWidget {
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
              CardEvolucao(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
