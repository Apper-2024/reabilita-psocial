import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/model/endereco_model.dart';
import 'package:reabilita_social/model/profissional/profissional_model.dart';
import 'package:reabilita_social/repository/administrador/cria_user_adm.dart';
import 'package:reabilita_social/widgets/anexo.dart';
import 'package:reabilita_social/widgets/dropdown_custom.dart';
import 'package:reabilita_social/widgets/endereco_form.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/listas.dart';
import 'package:reabilita_social/utils/snack/snack_atencao.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/utils/snack/snack_sucesso.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;
  String _selectedUserType = 'Administrador';
  bool isLoading = false;

  final ProfissionalModel profissionalModel = ProfissionalModel(
    nome: '',
    email: '',
    telefone: '',
    genero: null,
    cpf: '',
    raca: null,
    profissao: null,
    localTrabalho: null,
    endereco: EnderecoModel(
      cep: '',
      rua: '',
      numero: '',
      bairro: '',
      cidade: '',
      estado: '',
      complemento: '',
    ),
    tipoUsuario: 'profissional',
    statusConta: 'ativo',
    dataNascimento: Timestamp.now(),
    urlFoto: '',
    uidProfissional: '',
  );

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_image == null) {
        snackAtencao(context, "Por favor, selecione ou tire uma foto!");
        return;
      }

      setState(() {
        isLoading = true;
      });

      try {
        await UserService.createUser(
          userType: _selectedUserType,
          userData: profissionalModel.toMap(),
          imageFile: _image!,
        );
        snackSucesso(context, "Usuário adicionado com sucesso!");
        Navigator.pop(context);
      } catch (e) {
        snackErro(context, "Erro: ${e.toString()}");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Adicionar Usuário', style: TextStyle(color: preto1)),
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: preto1),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                CustomDropdownButton(
                  hint: 'Tipo de Usuário',
                  dropdownValue: _selectedUserType,
                  items: const ['Administrador', 'Profissional'],
                  onChanged: (value) => setState(() {
                    _selectedUserType = value!;
                  }),
                ),
                const SizedBox(height: 16),
                ...(_selectedUserType == 'Administrador'
                        ? ['Nome', 'Email', 'Telefone']
                        : ['Nome', 'Email', 'Telefone', 'CPF'])
                    .map((field) => Column(
                          children: [
                            TextFieldCustom(
                              labelText: field,
                              hintText: 'Digite $field',
                              onSaved: (value) {
                                if (_selectedUserType == 'Profissional') {
                                  switch (field) {
                                    case 'Nome':
                                      profissionalModel.nome = value!;
                                      break;
                                    case 'Email':
                                      profissionalModel.email = value!;
                                      break;
                                    case 'Telefone':
                                      profissionalModel.telefone = value!;
                                      break;
                                    case 'CPF':
                                      profissionalModel.cpf = value!;
                                      break;
                                  }
                                } else if (_selectedUserType ==
                                    'Administrador') {
                                  switch (field) {
                                    case 'Nome':
                                      profissionalModel.nome = value!;
                                      break;
                                    case 'Email':
                                      profissionalModel.email = value!;
                                      break;
                                    case 'Telefone':
                                      profissionalModel.telefone = value!;
                                      break;
                                  }
                                }
                              },
                              tipoTexto: field == 'Email'
                                  ? TextInputType.emailAddress
                                  : field == 'Telefone'
                                      ? TextInputType.phone
                                      : field == 'CPF'
                                          ? TextInputType.number
                                          : TextInputType.text,
                            ),
                            const SizedBox(height: 16),
                          ],
                        )),
                if (_selectedUserType == 'Profissional') ...[
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
                  CustomDropdownButton(
                    hint: 'Raça',
                    dropdownValue: profissionalModel.raca,
                    items: raca,
                    onChanged: (value) {
                      setState(() {
                        profissionalModel.raca = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomDropdownButton(
                    hint: 'Profissão',
                    dropdownValue: profissionalModel.profissao,
                    items: profissoes,
                    onChanged: (value) {
                      setState(() {
                        profissionalModel.profissao = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomDropdownButton(
                    hint: 'Local de Trabalho',
                    dropdownValue: profissionalModel.localTrabalho,
                    items: locaisDeTrabalho,
                    onChanged: (value) {
                      setState(() {
                        profissionalModel.localTrabalho = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  EnderecoForm(
                    onCepSaved: (value) =>
                        profissionalModel.endereco.cep = value,
                    onRuaSaved: (value) =>
                        profissionalModel.endereco.rua = value,
                    onNumeroSaved: (value) =>
                        profissionalModel.endereco.numero = value,
                    onBairroSaved: (value) =>
                        profissionalModel.endereco.bairro = value,
                    onCidadeSaved: (value) =>
                        profissionalModel.endereco.cidade = value,
                    onEstadoSaved: (value) =>
                        profissionalModel.endereco.estado = value,
                    onComplementoSaved: (value) =>
                        profissionalModel.endereco.complemento = value,
                    titulo: 'Informações Residenciais',
                  ),
                ],
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    UserService.pickImage().then((foto) {
                      setState(() {
                        _image = foto;
                      });
                    });
                  },
                  child: const Text(
                    "Tire uma foto ou selecione uma imagem",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: preto1),
                  ),
                ),
                if (_image != null) Anexo(arquivoBytes: _image!),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: isLoading ? Colors.grey : verde1),
                  child: isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Criar Usuário',
                          style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
