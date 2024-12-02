import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_profissionais.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Veja os profissionais cadastrados',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: preto1,
                ),
              ),
              const SizedBox(height: 16),
              CardProfissionais(
                onTap: () {},
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
