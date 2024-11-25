import 'package:flutter/material.dart';
import 'package:reabilita_social/widgets/card_evolu%C3%A7%C3%A3o.dart';
import '../utils/colors.dart';
import '../widgets/header.dart';

void main() {
  runApp(const MaterialApp(
    home: EvolucaoScreen(),
  ));
}

class EvolucaoScreen extends StatelessWidget {
  const EvolucaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
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
              CardEvolucao(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
