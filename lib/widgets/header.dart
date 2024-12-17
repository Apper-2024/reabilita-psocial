import 'package:flutter/material.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';
import '../utils/colors.dart';

class Header extends StatelessWidget {
  // final String imageUrl;

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
            ClipOval(
              child: Image.network(
                profissionalProvider.profissional!.urlFoto,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            InkWell(
              onTap: () {
                AuthRepository().signOut();
                Navigator.pushNamed(context, '/login');
              },
              child: const Stack(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    size: 38,
                    color: preto1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
