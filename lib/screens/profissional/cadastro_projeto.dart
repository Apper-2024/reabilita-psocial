import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reabilita_social/controller/image_controller.dart';
import 'package:reabilita_social/enum/enum_status_conta.dart';
import 'package:reabilita_social/enum/enum_tipo_usuario.dart';
import 'package:reabilita_social/model/endereco_model.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';
import 'package:reabilita_social/repository/paciente/gerencia_paciente_repository.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/formaters/formater_data.dart';
import 'package:reabilita_social/utils/listas.dart';
import 'package:reabilita_social/utils/snack/snack_atencao.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/utils/snack/snack_sucesso.dart';
import 'package:reabilita_social/widgets/anexo.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/inputText/custom_form_data.dart';
import 'package:reabilita_social/widgets/dropdown_custom.dart';
import 'package:reabilita_social/widgets/endereco_form.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';

class CadastroProjetoScreen extends StatefulWidget {
  const CadastroProjetoScreen({super.key});

  @override
  _CadastroProjetoScreenState createState() => _CadastroProjetoScreenState();
}

class _CadastroProjetoScreenState extends State<CadastroProjetoScreen> {
  Uint8List? _image;
  Uint8List? _pdf;
  bool _carregando = false;
  final paciente = PacienteModel(
    url: '',
    dadosPacienteModel: DadosPacienteModel(
      nome: "",
      dataNascimento: "",
      cns: "",
      email: "",
      telefone: "",
      genero: null,
      profissao: "",
      rendaMensal: "",
      tipoUsuario: EnumTipoUsuario.paciente.name,
      statusConta: EnumStatusConta.pendente.name,
      endereco: EnderecoModel(
        cep: "",
        rua: "",
        bairro: "",
        cidade: "",
        estado: "",
        complemento: "",
        numero: "",
      ),
      outrasInformacoes: OutrasInformacoesModel(
        observacao: "",
        outrasInformacoes: "",
        pacienteCuratelado: false,
        tecnicoReferencia: "",
      ),
      dataCriacao: Timestamp.now(),
      uidProfisional: "",
      urlFoto: "",
      uidPaciente: "",
      uidDocumento: "",
    ),
  );
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dataNascimento = TextEditingController();
  bool? pacienteCuratelado = false;
  @override
  Widget build(BuildContext context) {
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
                  'Cadastrar Paciente',
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
                TextFieldCustom(
                  tipoTexto: TextInputType.text,
                  hintText: "ex. João da Silva",
                  labelText: "Nome",
                  senha: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    paciente.dadosPacienteModel.nome = value!;
                  },
                ),
                const SizedBox(height: 16),
                CustomFormData(
                  labelText: "Data de nascimento",
                  formController: _dataNascimento,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Este campo é obrigatório!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    paciente.dadosPacienteModel.dataNascimento = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  tipoTexto: TextInputType.number,
                  hintText: "ex. 773163455630005",
                  labelText: "CNS",
                  senha: false,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    paciente.dadosPacienteModel.cns = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  tipoTexto: TextInputType.emailAddress,
                  hintText: "ex. joao@gmail.com",
                  labelText: "E-mail",
                  senha: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    paciente.dadosPacienteModel.email = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  tipoTexto: TextInputType.number,
                  hintText: "ex. (16) 99999-9999",
                  labelText: "Número de telefone",
                  senha: false,
                  inputFormatters: [telefoneFormater],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    paciente.dadosPacienteModel.telefone = value!;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdownButton(
                  dropdownValue: paciente.dadosPacienteModel.genero,
                  hint: 'Gênero',
                  items: generos,
                  onChanged: (value) {
                    setState(() {
                      paciente.dadosPacienteModel.genero = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  tipoTexto: TextInputType.text,
                  hintText: "ex. Diarista, advogado, psicólogo...",
                  labelText: "Profissão",
                  senha: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    paciente.dadosPacienteModel.profissao = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  tipoTexto: TextInputType.number,
                  hintText: "R\$",
                  labelText: "Renda",
                  senha: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyPtBrInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    paciente.dadosPacienteModel.rendaMensal = value!;
                  },
                ),
                const SizedBox(height: 16),
                EnderecoForm(
                  titulo: 'Informações Residênciais',
                  onCepSaved: (value) {
                    paciente.dadosPacienteModel.endereco.cep = value;
                  },
                  onRuaSaved: (value) {
                    paciente.dadosPacienteModel.endereco.rua = value;
                  },
                  onBairroSaved: (value) {
                    paciente.dadosPacienteModel.endereco.bairro = value;
                  },
                  onCidadeSaved: (value) {
                    paciente.dadosPacienteModel.endereco.cidade = value;
                  },
                  onEstadoSaved: (value) {
                    paciente.dadosPacienteModel.endereco.estado = value;
                  },
                  onComplementoSaved: (value) {
                    paciente.dadosPacienteModel.endereco.complemento = value;
                  },
                  onNumeroSaved: (value) {
                    paciente.dadosPacienteModel.endereco.numero = value;
                  },
                ),
                const SizedBox(height: 16),

                //levar para paciente - a baixo
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Principal Rede de Apoio/Suporte do Paciente",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: verde2,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                TextFieldCustom(
                  tipoTexto: TextInputType.multiline,
                  hintText: "ex. João - (16) 99999-9999",
                  labelText: "Nomes, contatos, endereços",
                  senha: false,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    paciente.dadosPacienteModel.outrasInformacoes.outrasInformacoes = value!;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      "Paciente Curatelado?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: verde2,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IntrinsicWidth(
                            child: ListTile(
                              title: const Text('Sim'),
                              leading: Radio<bool>(
                                activeColor: verde1,
                                value: true,
                                groupValue: pacienteCuratelado,
                                onChanged: (bool? value) {
                                  setState(() {
                                    pacienteCuratelado = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('Não'),
                              leading: Radio<bool>(
                                activeColor: verde1,
                                value: false,
                                groupValue: pacienteCuratelado,
                                onChanged: (bool? value) {
                                  setState(() {
                                    pacienteCuratelado = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  tipoTexto: TextInputType.text,
                  hintText: "ex. José",
                  labelText: "Técnico de Referência",
                  senha: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    paciente.dadosPacienteModel.outrasInformacoes.tecnicoReferencia = value!;
                  },
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Outras Informações",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: verde1,
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                TextFieldCustom(
                  tipoTexto: TextInputType.multiline,
                  hintText: "Outras informações",
                  labelText:
                      "Pense... Há informações muito importantes para ajudar no processo de reabilitação psicossocial?",
                  senha: false,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    paciente.dadosPacienteModel.outrasInformacoes.observacao = value!;
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    ImagePickerUtil.pegarFoto(context, (foto) {
                      setState(() {
                        _image = foto;
                      });
                    }, (pdf) {
                      setState(() {
                        _pdf = pdf;
                      });
                    }, true);
                  },
                  child: const Text(
                    "Tire uma foto ou selecione uma imagem do Paciente",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: preto1),
                  ),
                ),
                if (_image != null) Anexo(arquivoBytes: _image!),
                if (_pdf != null)
                  const Center(
                      child: Text('PDF SELECIONADO COM SUCESSO!', style: TextStyle(color: verde1, fontSize: 16))),
                const SizedBox(height: 32),
                Botaoprincipal(
                  text: "Finalizar Cadastro do Projeto",
                  carregando: _carregando,
                  onPressed: () async {
                    try {
                      if (!_formKey.currentState!.validate()) {
                        snackAtencao(context, "Preencha todos os campos obrigatórios");
                        return;
                      }
                      _formKey.currentState!.save();

                      if (paciente.dadosPacienteModel.genero == null) {
                        snackAtencao(context, "Selecione o gênero");
                        return;
                      }

                      // if (_image == null) {
                      //   snackAtencao(context, "Selecione uma foto");
                      //   return;
                      // }

                      setState(() {
                        _carregando = true;
                      });
                      paciente.dadosPacienteModel.outrasInformacoes.pacienteCuratelado = pacienteCuratelado!;

                      paciente.dadosPacienteModel.uidProfisional = FirebaseAuth.instance.currentUser!.uid;

                      String telefone = paciente.dadosPacienteModel.telefone;

                      String senha = telefone.substring(telefone.length - 4);

                      paciente.dadosPacienteModel.dataCriacao = Timestamp.now();

                      await GerenciaPacienteRepository().cadastrarPacienteNovo(paciente.dadosPacienteModel,
                          _image ?? _pdf, _image != null ? 'jpg' : 'pdf', senha);

                      setState(() {
                        _carregando = false;
                      });
                      snackSucesso(context, "Sucesso ao criar paciente!, senha ultimos 4 digitos do telefone");
                      Navigator.pop(context);

                      return;
                    } catch (e) {
                      setState(() {
                        _carregando = false;
                      });
                      snackErro(context, e.toString());
                      Navigator.pop(context);
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
