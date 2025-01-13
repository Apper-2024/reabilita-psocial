import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';
import 'package:reabilita_social/screens/auth/resetar_senha.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/verifica_conta.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/protecao_dados.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool verSenha = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  "assets/imagens/logo.png",
                  height: 120,
                ),
              ),
              const SizedBox(height: 30),

              const Center(
                child: Text(
                  'Olá, bem-vindo de volta ao Reabilita Social!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Formulário com sombra
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldCustom(
                        tipoTexto: TextInputType.emailAddress,
                        hintText: "ex. joao@gmail.com",
                        labelText: "Digite seu email",
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
                      const SizedBox(height: 20),
                      TextFieldCustom(
                        hintText: "*******",
                        labelText: "Senha",
                        tipoTexto: TextInputType.text,
                        senha: verSenha,
                        formController: senhaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          if (value.length < 6) {
                            return 'Senha deve possuir mais de 6 dígitos!';
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

                      // Alinhados à esquerda
                      InkWell(
                        onTap: () {
                          BottomSheetRedefinirSenha.show(context);
                        },
                        child: const Text(
                          'Esqueceu sua senha?',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/loginPrimeiroAcesso");
                        },
                        child: const Text(
                          'Primeiro acesso, paciente?',
                          style: TextStyle(
                            color: preto1,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Botaoprincipal(
                        text: 'Login',
                        onPressed: () async {
                          try {
                            final usuario =
                                await AuthRepository().fazerLogin(emailController.text, senhaController.text);
                            verificaUser(context, usuario);
                          } catch (e) {
                            snackErro(context, e.toString());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Cadastro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Não tem uma conta?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
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
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: () {
                    ProtecaoDialog.show(context);
                  },
                  child: const Text(
                    'Termo e Condições de Uso do webapp “App projeto de reabilitação psicossocial”',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: verde1,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
