import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/auth/cadastro.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/botom_menu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool verSenha = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Olá, bem-vindo de volta 🥶🥶',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 33),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 39),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Digite seu email",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite seu email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: senhaController,
                      obscureText: !verSenha,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Digite sua senha",
                        suffixIcon: IconButton(
                          icon: Icon(
                            verSenha ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              verSenha = !verSenha;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite sua senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          onTap: () {
                            print('clicado');
                          },
                          child: const Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        )),
                    const SizedBox(height: 20),
                    Botaoprincipal(
                      text: 'Login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BotomMenu()));

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login realizado!')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Erro no login')),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Não tem uma conta?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CadastroScreen()));
                          },
                          child: const Text(
                            'Se cadastre',
                            style: TextStyle(
                              color: verde1,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('Proteção e Visibilidade de Dados clicado');
              },
              child: const Text(
                'Proteção e Visibilidade de Dados',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: verde1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
