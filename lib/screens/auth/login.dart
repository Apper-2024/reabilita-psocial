import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/utils/snack/snack_sucesso.dart';
import 'package:reabilita_social/widgets/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';

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
              'Olá, bem-vindo de volta ao Reabilita Social!',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 33),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 39),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldCustom(
                      tipoTexto: TextInputType.emailAddress,
                      hintText: "Digite seu email",
                      labelText: "ex. joao@gmail.com",
                      senha: false,
                      formController: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFieldCustom(
                      hintText: "Senha",
                      labelText: "*******",
                      tipoTexto: TextInputType.text,
                      senha: verSenha,
                      formController: senhaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }

                        if (value.length < 6) {
                          return 'Senha deve possuir mais de 6 digitos!';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          verSenha ? Icons.visibility : Icons.visibility_off,
                          color: preto1,
                        ),
                        onPressed: () {
                          setState(() {
                            verSenha = !verSenha;
                          });
                        },
                      ),
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
                      onPressed: () async {
                        try {
                          await AuthRepository().fazerLogin(emailController.text, senhaController.text);
                          Navigator.pushNamed(context, '/menuPrincipal');
                          snackSucesso(context, "Login feito com sucesso");
                        } catch (e) {
                          snackErro(context, e.toString());
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
                            Navigator.pushNamed(context, "/cadastro");
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
