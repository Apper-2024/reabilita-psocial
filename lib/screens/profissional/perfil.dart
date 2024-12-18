import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/profissional/edita_perfil_prof.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import '../../utils/colors.dart';
import '../../widgets/header.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
                // imageUrl:
                //     'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                ),
            const SizedBox(height: 16),
            const Text(
              'Meu Perfil',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                color: preto1,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditarPerfilScreen(),
                  ),
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.account_circle, size: 36),
                  SizedBox(width: 10),
                  Text(
                    'Editar Perfil',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.help_rounded, size: 36),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Ajuda e Suporte',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.document_scanner, size: 36),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Termos de Uso',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Botaoprincipal(
              text: "Sair",
              onPressed: () {
                Navigator.pushNamed(context, "/");
              },
            ),
          ],
        ),
      ),
    );
  }
}
