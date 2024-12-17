import 'dart:typed_data';
import 'package:flutter/material.dart';
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
  final Map<String, dynamic> _userData = {};
  Uint8List? _image;
  String _selectedUserType = 'Administrador';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_image == null) {
        snackAtencao(context, "Por favor, selecione ou tire uma foto!");
        return;
      }

      try {
        await UserService.createUser(
          userType: _selectedUserType,
          userData: _userData,
          imageFile: _image!,
        );
        snackSucesso(context, "Usuário adicionado com sucesso!");
        Navigator.pop(context);
      } catch (e) {
        snackErro(context, "Erro: ${e.toString()}");
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
                              onSaved: (value) =>
                                  _userData[field.toLowerCase()] = value,
                              tipoTexto: field == 'Email'
                                  ? TextInputType.emailAddress
                                  : field == 'Telefone'
                                      ? TextInputType.phone
                                      : field == 'CPF'
                                          ? TextInputType.number
                                          : TextInputType
                                              .text, // Padrão para texto
                            ),
                            const SizedBox(
                                height: 16), // Adicionando espaçamento
                          ],
                        )),
                if (_selectedUserType == 'Profissional') ...[
                  Column(
                    children: [
                      CustomDropdownButton(
                        hint: 'Raça',
                        items: raca,
                        onChanged: (value) => _userData['raça'] = value,
                      ),
                      const SizedBox(height: 16), // Espaçamento

                      CustomDropdownButton(
                        hint: 'Profissão',
                        items: profissoes,
                        onChanged: (value) => _userData['profissao'] = value,
                      ),
                      const SizedBox(height: 16), // Espaçamento

                      CustomDropdownButton(
                        hint: 'Local de Trabalho',
                        items: locaisDeTrabalho,
                        onChanged: (value) =>
                            _userData['localTrabalho'] = value,
                      ),
                      const SizedBox(height: 16), // Espaçamento
                    ],
                  ),
                  EnderecoForm(
                    onCepSaved: (value) => _userData['cep'] = value,
                    onRuaSaved: (value) => _userData['rua'] = value,
                    onNumeroSaved: (value) => _userData['numero'] = value,
                    onBairroSaved: (value) => _userData['bairro'] = value,
                    onCidadeSaved: (value) => _userData['cidade'] = value,
                    onEstadoSaved: (value) => _userData['estado'] = value,
                    onComplementoSaved: (value) =>
                        _userData['complemento'] = value,
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
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(backgroundColor: verde1),
                  child: const Text('Salvar',
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
