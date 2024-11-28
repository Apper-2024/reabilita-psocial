import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reabilita_social/model/endereco_model.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/formaters/formater_data.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/custom_form_data.dart';
import 'package:reabilita_social/widgets/dropdown_custom.dart';
import 'package:reabilita_social/widgets/endereco_form.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';

class CadastroProjetoScreen extends StatefulWidget {
  const CadastroProjetoScreen({super.key});

  @override
  _CadastroProjetoScreenState createState() => _CadastroProjetoScreenState();
}

class _CadastroProjetoScreenState extends State<CadastroProjetoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dataNascimento = TextEditingController();
  bool? pacienteCuratelado = false;
  @override
  Widget build(BuildContext context) {
    List<String> generos = ['Masculino', 'Feminino', 'Outro'];

    final paciente = PacienteModel(
      dadosPacienteModel: DadosPacienteModel(
        nome: "",
        dataNascimento: "",
        cns: "",
        email: "",
        telefone: "",
        genero: null,
        profissao: "",
        rendaMensal: "",
        tipoUsuario: "",
        statusConta: "",
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
      ),
    );

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
                  labelText: "Email",
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
                  labelText: "CNS",
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
                  hint: 'Genero',
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
                  hintText: "ex. Profissional da Saúde",
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
                  hintText: "ex. 1.000,00",
                  labelText: "Salário",
                  senha: false,
                  inputFormatters: [
                    CurrencyPtBrInputFormatter(),
                    FilteringTextInputFormatter.digitsOnly,
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
                  tipoTexto: TextInputType.text,
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
                  labelText: "Tecnico de Referência",
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
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
                  tipoTexto: TextInputType.text,
                  hintText: "Outras informações",
                  labelText: "Observações sobre o paciente",
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
                const SizedBox(height: 32),
                Botaoprincipal(
                  text: "Cadastrar",
                  onPressed: () async {
                    try {
                      // if (profissional.raca == null) {
                      //   snackAtencao(context, "Selecione um raça");
                      //   return;
                      // }
                      // if (profissional.profissao == null) {
                      //   snackAtencao(context, "Selecione sua profissão");
                      //   return;
                      // }

                      // if (profissional.localTrabalho == null) {
                      //   snackAtencao(context, "Selecione o seu local de trabalho");
                      //   return;
                      // }
                      // _formKey.currentState!.save();

                      // final usuario = await AuthRepository().criarUsuario(profissional.email, senha);

                      // await GerenciaProfissionalRepository().criaProfissional(usuario, profissional);
                      // Navigator.pushNamedAndRemoveUntil(context, "/menuPrincipal", (route) => false);
                      // snackSucesso(context, "Sucesso ao criar sua conta!");
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
