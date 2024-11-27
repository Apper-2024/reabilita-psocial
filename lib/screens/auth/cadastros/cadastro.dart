import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/enum/enum_status_conta.dart';
import 'package:reabilita_social/enum/enum_tipo_usuario.dart';
import 'package:reabilita_social/model/endereco_model.dart';
import 'package:reabilita_social/model/profissional/profissional_model.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/formaters/formater_data.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/widgets/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/dropdown_custom.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  bool concordo = false;
  bool _escondidoSenha = true;
  bool _escondidoRepetirSenha = true;
  final _senhaController = TextEditingController();
  final _repetirSenhaController = TextEditingController();

  final ProfissionalModel profissionalModel = ProfissionalModel(
    email: '',
    nome: '',
    telefone: '',
    uidProfissional: "",
    endereco: EnderecoModel(
      cep: '',
      cidade: '',
      estado: '',
      bairro: '',
      complemento: '',
      numero: '',
      rua: '',
    ),
    genero: null,
    cpf: ',',
    dataNascimento: Timestamp.now(),
    localTrabalho: null,
    profissao: null,
    raca: null,
    statusConta: EnumStatusConta.analise.name,
    tipoUsuario: EnumTipoUsuario.profissional.name,
  );

  @override
  Widget build(BuildContext context) {
    List<String> generos = ['Masculino', 'Feminino', 'Outro'];
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 36),
                const Text(
                  'Crie uma conta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Gerencie e acompanhe a evolução dos pacientes!',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                TextFieldCustom(
                  tipoTexto: TextInputType.name,
                  hintText: "Nome Completo",
                  labelText: "ex. João da Silva",
                  senha: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    profissionalModel.nome = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  tipoTexto: TextInputType.emailAddress,
                  hintText: "Digite seu email",
                  labelText: "ex. joao@gmail.com",
                  senha: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    profissionalModel.email = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  tipoTexto: TextInputType.phone,
                  hintText: "Telefone",
                  labelText: "(xx) xxxxx-xxxx",
                  senha: false,
                  inputFormatters: [telefoneFormater],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    profissionalModel.telefone = value!;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdownButton(
                  hint: 'Gênero',
                  dropdownValue: profissionalModel.genero,
                  items: generos,
                  onChanged: (value) {
                    setState(() {
                      profissionalModel.genero = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Senha",
                  labelText: "*******",
                  tipoTexto: TextInputType.text,
                  senha: _escondidoSenha,
                  formController: _senhaController,
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
                      _escondidoSenha ? Icons.visibility : Icons.visibility_off,
                      color: preto1,
                    ),
                    onPressed: () {
                      setState(() {
                        _escondidoSenha = !_escondidoSenha;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Repetir Senha",
                  labelText: "*******",
                  tipoTexto: TextInputType.text,
                  senha: _escondidoRepetirSenha,
                  formController: _repetirSenhaController,
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
                      _escondidoRepetirSenha ? Icons.visibility : Icons.visibility_off,
                      color: preto1,
                    ),
                    onPressed: () {
                      setState(() {
                        _escondidoRepetirSenha = !_escondidoRepetirSenha;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: concordo,
                      onChanged: (bool? value) {
                        setState(() {
                          concordo = value!;
                        });
                      },
                      checkColor: branco,
                      activeColor: verde1,
                    ),
                    const Expanded(
                      child: Text(
                        'Li e concordo com os termos da Política de Privacidade',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Botaoprincipal(
                  text: "Continuar",
                  onPressed: () async {
                    try {
                      // if (_senhaController.text != _repetirSenhaController.text) {
                      //   snackAtencao(context, "Senhas devem ser iguais!");
                      //   return;
                      // }

                      // if (profissionalModel.genero == null) {
                      //   snackAtencao(context, "Deve selecionar o gênero!");
                      //   return;
                      // }
                      // if (!_formKey.currentState!.validate()) {
                      //   snackAtencao(context, "Preencha os campos corretamente!");
                      //   return;
                      // }

                      // if (concordo == false) {
                      //   snackAtencao(context, "Por favor, aceite os termos de uso!");
                      //   return;
                      // }
                      _formKey.currentState!.save();

                      Navigator.pushNamed(context, '/cadastroFinal', arguments: {
                        'profissional': profissionalModel,
                        'senha': _senhaController.text,
                      });

                      // await AuthRepository().criarUsuario(profissionalModel.email, _senhaController.text);
                    } catch (e) {
                      snackErro(context, e.toString());
                      return;
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Já possui conta? ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: verde1,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
