import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/enum/enum_status_conta.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';
import 'package:reabilita_social/repository/paciente/gerencia_paciente_repository.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/utils/snack/snack_sucesso.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';

class LoginPrimeiroAcesso extends StatefulWidget {
  const LoginPrimeiroAcesso({super.key});

  @override
  _LoginPrimeiroAcessoState createState() => _LoginPrimeiroAcessoState();
}

class _LoginPrimeiroAcessoState extends State<LoginPrimeiroAcesso> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cnsController = TextEditingController();
  final TextEditingController senhaAcessoController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController repetirSenhaController = TextEditingController();

  bool verSenhaAcesso = true;
  bool verSenha = true;
  bool verRepetirSenha = true;
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
              'Preencha os campos abaixo para criar sua conta',
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
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      tipoTexto: TextInputType.emailAddress,
                      hintText: "ex. 123456789012345",
                      labelText: "Digite seu cns",
                      senha: false,
                      formController: cnsController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      hintText: "*******",
                      labelText: "Senha de acesso",
                      tipoTexto: TextInputType.text,
                      senha: verSenhaAcesso,
                      formController: senhaAcessoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }

                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          verSenhaAcesso ? Icons.visibility : Icons.visibility_off,
                          color: preto1,
                        ),
                        onPressed: () {
                          setState(() {
                            verSenhaAcesso = !verSenhaAcesso;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      hintText: "*******",
                      labelText: "Repetir senha",
                      tipoTexto: TextInputType.text,
                      senha: verRepetirSenha,
                      formController: repetirSenhaController,
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
                          verRepetirSenha ? Icons.visibility : Icons.visibility_off,
                          color: preto1,
                        ),
                        onPressed: () {
                          setState(() {
                            verRepetirSenha = !verRepetirSenha;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    Botaoprincipal(
                      text: 'Cadastrar',
                      onPressed: () async {
                        try {
                          if (senhaController.text != repetirSenhaController.text) {
                            snackErro(context, 'As senhas não são iguais');
                            return;
                          }
                          if (!_formKey.currentState!.validate()) {
                            snackErro(context, 'Campos obrigatórios não preenchidos');
                            return;
                          }

                          GerenciaPacienteRepository gerencia = GerenciaPacienteRepository();

                          final paciente = await gerencia.verificaSenha(
                              senhaAcessoController.text, emailController.text, cnsController.text);

                          final pacient = paciente!['paciente'] as PacienteModel;
                          final uid = paciente['uidColletion'];

                          final user = await AuthRepository().criarUsuario(emailController.text, senhaController.text);

                          pacient.dadosPacienteModel.statusConta = EnumStatusConta.ativo.name;
                          pacient.dadosPacienteModel.uidPaciente = user.user!.uid;

                          await gerencia.editarPaciente(pacient.dadosPacienteModel, uid.toString());

                          snackSucesso(context, "Sua conta foi criada com sucesso!, faça login para acessar");
                          Navigator.pop(context);
                        } catch (e) {
                          snackErro(context, e.toString());
                          Navigator.pop(context);
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    Botaoprincipal(
                      text: 'Cancelar',
                      cor: vermelho,
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
