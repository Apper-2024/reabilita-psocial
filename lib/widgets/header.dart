
import 'package:flutter/material.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';

class Header extends StatelessWidget {
  Header({
    super.key,
  });

  ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Forma intermediária entre oval e quadrado
                image: DecorationImage(
                  image: NetworkImage(profissionalProvider.profissional!.urlFoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
              AuthRepository().signOut(); // Remove autenticação do Firebase
              Navigator.pushNamedAndRemoveUntil(context, '/login',
                  (route) => false); // Redireciona para o login
            
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      size: 24,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Sair",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
