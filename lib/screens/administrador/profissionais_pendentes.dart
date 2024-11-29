import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_profissionais.dart';
import 'package:reabilita_social/widgets/card/card_projeto.dart';

class ProfissionaisPendentesScreen extends StatefulWidget {
  const ProfissionaisPendentesScreen({super.key});

  @override
  _ProfissionaisPendentesScreenState createState() => _ProfissionaisPendentesScreenState();
}

class _ProfissionaisPendentesScreenState extends State<ProfissionaisPendentesScreen> {
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
              SizedBox(height: 16),
              Text(
                'Veja os profissionais pendentes',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: preto1,
                ),
              ),
              SizedBox(height: 16),
              CardProfissionais(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
