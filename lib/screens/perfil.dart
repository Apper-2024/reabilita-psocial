import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/home.dart';
import 'package:reabilita_social/screens/login.dart';
import 'package:reabilita_social/screens/paciente.dart';
import '../utils/colors.dart';
import '../widgets/header.dart';

class PerfilScreen extends StatelessWidget {
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
                'Meu Perfil',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: AppColors.preto1,
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  const Icon(Icons.account_circle, size: 36),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Editar Perfil',
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
                  const Icon(Icons.settings, size: 36),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Configuraçoes e Privacidade',
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
                  const Icon(Icons.help_rounded, size: 36),
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
                  const Icon(Icons.document_scanner, size: 36),
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
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.preto1),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.exit_to_app_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sair',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
