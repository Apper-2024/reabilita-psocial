import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_profissionais.dart';

class ProfissionaisPendentesScreen extends StatefulWidget {
  const ProfissionaisPendentesScreen({super.key});

  @override
  _ProfissionaisPendentesScreenState createState() => _ProfissionaisPendentesScreenState();
}

class _ProfissionaisPendentesScreenState extends State<ProfissionaisPendentesScreen> {
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
                'Veja os profissionais pendentes',
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
