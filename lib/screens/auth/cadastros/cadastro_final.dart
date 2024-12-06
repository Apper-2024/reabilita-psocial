import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:reabilita_social/controller/image_controller.dart';
import 'package:reabilita_social/model/profissional/profissional_model.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';
import 'package:reabilita_social/repository/profissional/gerencia_profissional_repository.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/formaters/formater_data.dart';
import 'package:reabilita_social/utils/listas.dart';
import 'package:reabilita_social/utils/snack/snack_atencao.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/utils/snack/snack_sucesso.dart';
import 'package:reabilita_social/widgets/anexo.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/dropdown_custom.dart';
import 'package:reabilita_social/widgets/endereco_form.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';

class CadastroFinalScreen extends StatefulWidget {
  const CadastroFinalScreen({super.key});

  @override
  _CadastroFinalScreenState createState() => _CadastroFinalScreenState();
}

class _CadastroFinalScreenState extends State<CadastroFinalScreen> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final profissional = args['profissional'] as ProfissionalModel;
    final senha = args['senha'];

   
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: preto1,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                  'Finalizar Cadastro',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Informações Pessoais',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                CustomDropdownButton(
                  dropdownValue: profissional.raca,
                  hint: 'Raça',
                  items: raca,
                  onChanged: (value) {
                    setState(() {
                      profissional.raca = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  tipoTexto: TextInputType.text,
                  hintText: "ex. 111.111.111-11",
                  labelText: "Digite seu cpf",
                  senha: false,
                  inputFormatters: [cpfFormater],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    profissional.cpf = value!;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdownButton(
                  hint: "Profissão",
                  dropdownValue: profissional.profissao,
                  items: profissoes,
                  onChanged: (value) {
                    setState(() {
                      profissional.profissao = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdownButton(
                  hint: "Local de Trabalho",
                  dropdownValue: profissional.localTrabalho,
                  items: locaisDeTrabalho,
                  onChanged: (value) {
                    setState(() {
                      profissional.localTrabalho = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                EnderecoForm(
                  titulo: 'Informações Residênciais',
                  onCepSaved: (value) {
                    profissional.endereco.cep = value;
                  },
                  onRuaSaved: (value) {
                    profissional.endereco.rua = value;
                  },
                  onBairroSaved: (value) {
                    profissional.endereco.bairro = value;
                  },
                  onCidadeSaved: (value) {
                    profissional.endereco.cidade = value;
                  },
                  onEstadoSaved: (value) {
                    profissional.endereco.estado = value;
                  },
                  onComplementoSaved: (value) {
                    profissional.endereco.complemento = value;
                  },
                  onNumeroSaved: (value) {
                    profissional.endereco.numero = value;
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    ImagePickerUtil.pegarFoto(context, (foto) {
                      setState(() {
                        _image = foto;
                      });
                    });
                  },
                  child: const Text(
                    "Tire uma foto ou selecione uma imagem",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: preto1),
                  ),
                ),
                if (_image != null) Anexo(arquivoBytes: _image!),
                const SizedBox(height: 16),
                Botaoprincipal(
                  text: "Cadastrar",
                  onPressed: () async {
                    try {
                      if (profissional.raca == null) {
                        snackAtencao(context, "Selecione um raça");
                        return;
                      }
                      if (profissional.profissao == null) {
                        snackAtencao(context, "Selecione sua profissão");
                        return;
                      }

                      if (profissional.localTrabalho == null) {
                        snackAtencao(context, "Selecione o seu local de trabalho");
                        return;
                      }

                       if (_image == null) {
                        snackAtencao(context, "Selecione uma foto");
                        return;
                      }
                      _formKey.currentState!.save();

                      final usuario = await AuthRepository().criarUsuario(profissional.email, senha);

                      await GerenciaProfissionalRepository().criaProfissional(usuario, profissional, _image!);
                      Navigator.pushNamedAndRemoveUntil(context, "/menuProfissional", (route) => false);
                      snackSucesso(context, "Sucesso ao criar sua conta!");
                    } catch (e) {
                      snackErro(context, e.toString());
                      return;
                    }
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
