import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reabilita_social/model/profissional/profissional_model.dart';
import 'package:reabilita_social/model/endereco_model.dart';
import 'package:reabilita_social/repository/profissional/gerencia_profissional_repository.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/snack/snack_atencao.dart';
import 'package:reabilita_social/utils/snack/snack_sucesso.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/dropdown_custom.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';
import 'package:reabilita_social/utils/listas.dart';

class EditaPerfilProf extends StatefulWidget {
  const EditaPerfilProf({super.key});

  @override
  State<EditaPerfilProf> createState() => _EditaPerfilProfState();
}

class _EditaPerfilProfState extends State<EditaPerfilProf> {
  final _formKey = GlobalKey<FormState>();
  final _repository = GerenciaProfissionalRepository();
  final _auth = FirebaseAuth.instance;

  Uint8List? _novaImagem;

  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _telefoneController;
  late TextEditingController _cpfController;
  late TextEditingController _tipoUsuarioController;
  late TextEditingController _statusContaController;
  late TextEditingController _dataNascimentoController;
  late TextEditingController _urlFotoController;

  late TextEditingController _ruaController;
  late TextEditingController _numeroController;
  late TextEditingController _bairroController;
  late TextEditingController _estadoController;
  late TextEditingController _cidadeController;
  late TextEditingController _cepController;
  late TextEditingController _complementoController;

  ProfissionalModel? _profissional;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDadosProfissional();
  }

  Future<void> _carregarDadosProfissional() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        final profissional = await _repository.buscaProfissional(uid);
        setState(() {
          _profissional = profissional;

          _nomeController = TextEditingController(text: profissional.nome);
          _emailController = TextEditingController(text: profissional.email);
          _telefoneController =
              TextEditingController(text: profissional.telefone);
          _cpfController = TextEditingController(text: profissional.cpf);
          _tipoUsuarioController =
              TextEditingController(text: profissional.tipoUsuario);
          _statusContaController =
              TextEditingController(text: profissional.statusConta);
          _dataNascimentoController = TextEditingController(
            text: profissional.dataNascimento.toDate().toString(),
          );
          _urlFotoController =
              TextEditingController(text: profissional.urlFoto);

          _ruaController =
              TextEditingController(text: profissional.endereco.rua);
          _numeroController =
              TextEditingController(text: profissional.endereco.numero);
          _bairroController =
              TextEditingController(text: profissional.endereco.bairro);
          _estadoController =
              TextEditingController(text: profissional.endereco.estado);
          _cidadeController =
              TextEditingController(text: profissional.endereco.cidade);
          _cepController =
              TextEditingController(text: profissional.endereco.cep);
          _complementoController = TextEditingController(
              text: profissional.endereco.complemento ?? '');

          _isLoading = false;
        });
      } else {
        throw 'Usuário não autenticado.';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar dados: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _salvarAlteracoes() async {
    if (_formKey.currentState!.validate()) {
      if (_profissional != null) {
        _profissional!.nome = _nomeController.text;
        _profissional!.email = _emailController.text;
        _profissional!.telefone = _telefoneController.text;
        _profissional!.cpf = _cpfController.text;
        _profissional!.tipoUsuario = _tipoUsuarioController.text;
        _profissional!.statusConta = _statusContaController.text;
        _profissional!.urlFoto = _urlFotoController.text;

        _profissional!.endereco = EnderecoModel(
          rua: _ruaController.text,
          numero: _numeroController.text,
          bairro: _bairroController.text,
          estado: _estadoController.text,
          cidade: _cidadeController.text,
          cep: _cepController.text,
          complemento: _complementoController.text,
        );

        try {
          await _repository.atualizaProfissional(_profissional!, _novaImagem);
          snackSucesso(context, "Usuário editado com sucesso!");
        } catch (e) {
          snackAtencao(context, "Tente novamente mais tarde!");
        }
      }
    }
  }

  Future<void> _selecionarImagem() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      Uint8List bytes = await file.readAsBytes();
      setState(() {
        _novaImagem = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: background,
        title: const Text('Editar Perfil'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _selecionarImagem,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _novaImagem != null
                                  ? MemoryImage(_novaImagem!)
                                  : (_profissional?.urlFoto != null
                                      ? NetworkImage(_profissional!.urlFoto)
                                      : null) as ImageProvider?,
                              child: _novaImagem == null &&
                                      _profissional?.urlFoto == null
                                  ? const Icon(Icons.camera_alt,
                                      size: 30, color: Colors.white)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Clique na imagem para alterar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      labelText: "Nome",
                      hintText: "Digite seu nome",
                      formController: _nomeController,
                      tipoTexto: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    CustomDropdownButton(
                      hint: "Gênero",
                      dropdownValue: _profissional?.genero != null &&
                              generos.contains(_profissional!.genero)
                          ? _profissional!.genero
                          : null,
                      items: generos,
                      onChanged: (value) {
                        setState(() {
                          _profissional!.genero = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomDropdownButton(
                      hint: "Profissão",
                      dropdownValue: _profissional?.profissao != null &&
                              profissoes.contains(_profissional!.profissao)
                          ? _profissional!.profissao
                          : null,
                      items: profissoes,
                      onChanged: (value) {
                        setState(() {
                          _profissional!.profissao = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomDropdownButton(
                      hint: "Local de Trabalho",
                      dropdownValue: _profissional?.localTrabalho != null &&
                              locaisDeTrabalho
                                  .contains(_profissional!.localTrabalho)
                          ? _profissional!.localTrabalho
                          : null,
                      items: locaisDeTrabalho,
                      onChanged: (value) {
                        setState(() {
                          _profissional!.localTrabalho = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomDropdownButton(
                      hint: "Raça",
                      dropdownValue: _profissional?.raca != null &&
                              raca.contains(_profissional!.raca)
                          ? _profissional!.raca
                          : null,
                      items: raca,
                      onChanged: (value) {
                        setState(() {
                          _profissional!.raca = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      labelText: "Email",
                      hintText: "Digite seu email",
                      formController: _emailController,
                      tipoTexto: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      labelText: "CPF",
                      hintText: "Digite seu CPF",
                      formController: _cpfController,
                      tipoTexto: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      labelText: "Telefone",
                      hintText: "Digite seu telefone",
                      formController: _telefoneController,
                      tipoTexto: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      labelText: "CEP",
                      hintText: "Digite o CEP",
                      formController: _cepController,
                      tipoTexto: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      labelText: "Rua",
                      hintText: "Digite sua rua",
                      formController: _ruaController,
                      tipoTexto: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    TextFieldCustom(
                      labelText: "Número",
                      hintText: "Digite o número da residência",
                      formController: _numeroController,
                      tipoTexto: TextInputType.text,
                    ),
                    const SizedBox(height: 24),
                    Botaoprincipal(
                      text: "Salvar",
                      onPressed: _salvarAlteracoes,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
