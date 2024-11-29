import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_profissionais.dart';
import 'package:reabilita_social/widgets/card/card_projeto.dart';

class ProfissionaisAceitosScreen extends StatefulWidget {
  const ProfissionaisAceitosScreen({super.key});

  @override
  _ProfissionaisAceitosScreenState createState() => _ProfissionaisAceitosScreenState();
}

class _ProfissionaisAceitosScreenState extends State<ProfissionaisAceitosScreen> {
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
              SizedBox(height: 16),
              Text(
                'Veja os profissionais cadastrados',
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
