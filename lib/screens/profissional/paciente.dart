import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reabilita_social/controller/image_controller.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_modal.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_multiprofissional_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/potencialidade_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/recurso_individuais_model.dart';
import 'package:reabilita_social/provider/imagem_provider.dart';
import 'package:reabilita_social/provider/paciente_provider.dart';
import 'package:reabilita_social/repository/paciente/gerencia_paciente_repository.dart';
import 'package:reabilita_social/screens/profissional/detalhes_paciente.dart';
import 'package:reabilita_social/screens/profissional/form_categoria.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/formaters/formater_data.dart';
import 'package:reabilita_social/utils/listas.dart';
import 'package:reabilita_social/utils/snack/snack_atencao.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/utils/snack/snack_sucesso.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import 'package:reabilita_social/widgets/dropdown_custom.dart';
import 'package:reabilita_social/widgets/text_field_custom.dart';

class PacienteScreen extends StatefulWidget {
  const PacienteScreen({super.key});

  @override
  _PacienteScreenState createState() => _PacienteScreenState();
}

class _PacienteScreenState extends State<PacienteScreen> {
  Future<void> _dialogDiagnosticoMultiprofissional(PacienteProvider pacienteProvider) async {
    final List<Uint8List> images = [];

    HistoriaCasoModel historiaCasoModel = HistoriaCasoModel(
      historia: null,
      diagnosticos: [],
      foto: [],
      dataCriacao: null,
    );
    DiagnosticoMultiprofissionaisModel diagnosticoMultiprofissionaisModel = DiagnosticoMultiprofissionaisModel(
      diagnosticos: '',
      dataCriacao: null,
      nomeResponsavel: '',
      profissaoResponsavel: null,
      cpf: '',
    );

    final formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cadastro de Diagnóstico Multiprofissional',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "....",
                          labelText: "História do caso",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            historiaCasoModel.historia = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. Depressão",
                          labelText: "Diagnostico",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            diagnosticoMultiprofissionaisModel.diagnosticos = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. 111.111.111-11",
                          labelText: "Digite o cpf",
                          senha: false,
                          inputFormatters: [cpfFormater],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            diagnosticoMultiprofissionaisModel.cpf = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. João da Silva",
                          labelText: "Nome do responsavel",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            diagnosticoMultiprofissionaisModel.nomeResponsavel = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomDropdownButton(
                          hint: "Profissão",
                          dropdownValue: diagnosticoMultiprofissionaisModel.profissaoResponsavel,
                          items: profissoes,
                          onChanged: (value) {
                            setStateDialog(() {
                              diagnosticoMultiprofissionaisModel.profissaoResponsavel = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          children: [
                            if (images.isNotEmpty)
                              ...images.map((image) => Container(
                                    width: MediaQuery.of(context).size.width * 0.22,
                                    height: MediaQuery.of(context).size.width * 0.22,
                                    color: Colors.grey[300],
                                    child: Image.memory(image, fit: BoxFit.cover),
                                  )),
                            if ((images.length ?? 0) < 3)
                              InkWell(
                                onTap: () {
                                  ImagePickerUtil.pegarFoto(context, (foto) {
                                    setStateDialog(() {
                                      images.add(foto);
                                    });
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.22,
                                  height: MediaQuery.of(context).size.width * 0.22,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.add_a_photo),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: Botaoprincipal(
                                text: "Cancelar",
                                cor: vermelho,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Botaoprincipal(
                                text: "Cadastrar",
                                onPressed: () async {
                                  try {
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    if (images.isEmpty) {
                                      snackAtencao(context, "Adicione uma imagem");
                                      return;
                                    }
                                    formKey.currentState!.save();
                                    diagnosticoMultiprofissionaisModel.dataCriacao = Timestamp.now();
                                    historiaCasoModel.dataCriacao = Timestamp.now();

                                    historiaCasoModel.diagnosticos?.add(diagnosticoMultiprofissionaisModel);

                                    await GerenciaPacienteRepository().cadastrarHistoria(
                                      historiaCasoModel,
                                      images,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setHistoria(historiaCasoModel);

                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    snackErro(context, "Erro ao cadastrar diagnóstico multiprofissional");
                                    return;
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _dialogUpdateDiagnosticoMulti(HistoriaCasoModel historia, PacienteProvider pacienteProvider) async {
    DiagnosticoMultiprofissionaisModel diagnosticoMultiprofissionaisModel = DiagnosticoMultiprofissionaisModel(
      diagnosticos: '',
      dataCriacao: null,
      nomeResponsavel: '',
      profissaoResponsavel: null,
      cpf: '',
    );
    final _formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cadastro de Diagnóstico Multiprofissional',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. Depressão",
                          labelText: "Diagnostico",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            diagnosticoMultiprofissionaisModel.diagnosticos = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. 111.111.111-11",
                          labelText: "Digite o cpf",
                          senha: false,
                          inputFormatters: [cpfFormater],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            diagnosticoMultiprofissionaisModel.cpf = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. João da Silva",
                          labelText: "Nome do responsavel",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            diagnosticoMultiprofissionaisModel.nomeResponsavel = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomDropdownButton(
                          hint: "Profissão",
                          dropdownValue: diagnosticoMultiprofissionaisModel.profissaoResponsavel,
                          items: profissoes,
                          onChanged: (value) {
                            setStateDialog(() {
                              diagnosticoMultiprofissionaisModel.profissaoResponsavel = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: Botaoprincipal(
                                text: "Cancelar",
                                cor: vermelho,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Botaoprincipal(
                                text: "Cadastrar",
                                onPressed: () async {
                                  try {
                                    if (!_formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    diagnosticoMultiprofissionaisModel.dataCriacao = Timestamp.now();

                                    historia.diagnosticos?.add(diagnosticoMultiprofissionaisModel);
                                    await GerenciaPacienteRepository().updateDiagnostico(
                                      historia.diagnosticos,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    snackErro(context, "Erro ao cadastrar diagnóstico multiprofissional");
                                    return;
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _dialogAdicionarRecursoIndividual(PacienteProvider pacienteProvider) async {
    Habilidades habilidade = Habilidades(dataCriacao: Timestamp.now(), habilidades: '');
    RecursoIndividuaisModel recursoIndividuaisModel = RecursoIndividuaisModel(
      habilidades: [],
      recursoIndividual: '',
    );
    final _formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cadastro de Recursos Individuais',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "",
                          labelText: "Recurso Individual",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            recursoIndividuaisModel.recursoIndividual = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "",
                          labelText: "Habilidade",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            habilidade.habilidades = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Botaoprincipal(
                                text: "Cancelar",
                                cor: vermelho,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Botaoprincipal(
                                text: "Cadastrar",
                                onPressed: () async {
                                  try {
                                    if (!_formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    habilidade.dataCriacao = Timestamp.now();

                                    recursoIndividuaisModel.habilidades?.add(habilidade);

                                    await GerenciaPacienteRepository().cadastraRecursoIndividual(
                                      recursoIndividuaisModel,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdateRecursoIndividual(recursoIndividuaisModel);

                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    snackErro(context, "Erro ao cadastrar, tente novamente mais tarde");
                                    return;
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _dialogAdicionarHabilidade(
      PacienteProvider pacienteProvider, RecursoIndividuaisModel recursoIndividuaisModel) async {
    Habilidades habilidade = Habilidades(dataCriacao: Timestamp.now(), habilidades: '');
    final _formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cadastro de Recursos Individuais',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "",
                          labelText: "Habilidade",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            habilidade.habilidades = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Botaoprincipal(
                                text: "Cancelar",
                                cor: vermelho,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Botaoprincipal(
                                text: "Cadastrar",
                                onPressed: () async {
                                  try {
                                    if (!_formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    habilidade.dataCriacao = Timestamp.now();

                                    recursoIndividuaisModel.habilidades?.add(habilidade);

                                    await GerenciaPacienteRepository().cadastraHabilidades(
                                      recursoIndividuaisModel.habilidades!,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    snackErro(context, "Erro ao cadastrar, tente novamente mais tarde");
                                    return;
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _dialogAdicionarPotencialidade(
      PacienteProvider pacienteProvider, PotencialidadeModel? potencialidadeModel) async {
    Potencialidade potencialidade = Potencialidade(dataCriacao: Timestamp.now(), potencialidade: '');
    final _formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cadastro de potencialidades',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "",
                          labelText: "Potencialidade",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            potencialidade.potencialidade = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Botaoprincipal(
                                text: "Cancelar",
                                cor: vermelho,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Botaoprincipal(
                                text: "Cadastrar",
                                onPressed: () async {
                                  try {
                                    if (!_formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    potencialidade.dataCriacao = Timestamp.now();

                                    // Inicialize a lista de potencialidades se estiver nula
                                    if (potencialidadeModel == null) {
                                      potencialidadeModel = PotencialidadeModel(potencialidades: []);
                                    }
                                    potencialidadeModel?.potencialidades ??= [];

                                    // Adicione a nova potencialidade à lista
                                    potencialidadeModel?.potencialidades!.add(potencialidade);

                                    await GerenciaPacienteRepository().cadastraPotencialidade(
                                      potencialidadeModel!,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdatePotencialidade(potencialidadeModel!);

                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    snackErro(context, "Erro ao cadastrar, tente novamente mais tarde");
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    PacienteProvider pacienteProvider = Provider.of<PacienteProvider>(context, listen: true);
    DadosPacienteModel dadosPacienteModel = pacienteProvider.paciente!.dadosPacienteModel;

    List<Widget> listaCard = [
      buildCardPaciente(
        context,
        icon: Icons.person,
        text: 'Dados do Paciente',
        detalhesPaciente: DetalhesPaciente(
          visible: false,
          conteudos: [
            ItemConteudo(
              titulo: 'Dados Pessoais',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Consumer<PacienteProvider>(
                    builder: (context, pacienteProvider, child) {
                      DadosPacienteModel dadosPacienteModel = pacienteProvider.paciente!.dadosPacienteModel;
                      return FormCategoria(
                        fields: [
                          FieldConfig(
                              label: 'Nome Completo',
                              hintText: dadosPacienteModel.nome,
                              widthFactor: 1.0,
                              valorInicial: dadosPacienteModel.nome),
                          FieldConfig(
                              label: 'Idade',
                              hintText: calculaIdade(dadosPacienteModel.dataNascimento).toString(),
                              valorInicial: calculaIdade(dadosPacienteModel.dataNascimento).toString(),
                              widthFactor: 0.5),
                          FieldConfig(
                              label: 'Gênero',
                              dropdownItems: generos,
                              isDropdownField: true,
                              onChangedDropdown: (value) {
                                dadosPacienteModel.genero = value!;
                                pacienteProvider.setPaciente(pacienteProvider.paciente!);
                              },
                              hintText: dadosPacienteModel.genero!,
                              widthFactor: 0.5,
                              valorInicial: dadosPacienteModel.genero),
                          FieldConfig(
                              label: 'CNS',
                              hintText: dadosPacienteModel.cns,
                              widthFactor: 1.0,
                              valorInicial: dadosPacienteModel.cns),
                          FieldConfig(
                              label: 'Profissão',
                              hintText: dadosPacienteModel.profissao,
                              widthFactor: 0.5,
                              valorInicial: dadosPacienteModel.profissao),
                          FieldConfig(
                              label: 'Renda Mensal',
                              hintText: dadosPacienteModel.rendaMensal,
                              widthFactor: 0.5,
                              valorInicial: dadosPacienteModel.rendaMensal),
                          FieldConfig(
                              label: 'CEP',
                              hintText: dadosPacienteModel.endereco.cep,
                              widthFactor: 0.5,
                              valorInicial: dadosPacienteModel.endereco.cep),
                          FieldConfig(
                              label: 'Bairro',
                              hintText: dadosPacienteModel.endereco.bairro,
                              widthFactor: 0.5,
                              valorInicial: dadosPacienteModel.endereco.bairro),
                          FieldConfig(
                              label: 'Logradouro',
                              hintText: dadosPacienteModel.endereco.rua,
                              widthFactor: 0.5,
                              valorInicial: dadosPacienteModel.endereco.rua),
                          FieldConfig(
                              label: 'Número',
                              hintText: dadosPacienteModel.endereco.numero,
                              widthFactor: 0.5,
                              valorInicial: dadosPacienteModel.endereco.numero),
                          FieldConfig(
                              label: 'Cidade',
                              hintText: dadosPacienteModel.endereco.cidade,
                              widthFactor: 0.5,
                              valorInicial: dadosPacienteModel.endereco.cidade),
                          FieldConfig(
                              label: 'Estado',
                              hintText: dadosPacienteModel.endereco.estado,
                              widthFactor: 0.5,
                              valorInicial: dadosPacienteModel.endereco.estado),
                        ],
                        titulo: 'Dados Pessoais',
                      );
                    },
                  ),
                ),
              ),
              onTap2: () {
                print("oi");
              },
            ),
            ItemConteudo(
              titulo: 'Outras Informações',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Consumer<PacienteProvider>(
                    builder: (context, pacienteProvider, child) {
                      DadosPacienteModel dadosPacienteModel = pacienteProvider.paciente!.dadosPacienteModel;
                      return FormCategoria(
                        fields: [
                          FieldConfig(
                              label: 'Principal Rede de Apoio/Suporte do Paciente',
                              hintText: dadosPacienteModel.outrasInformacoes.outrasInformacoes,
                              widthFactor: 1.0,
                              valorInicial: dadosPacienteModel.outrasInformacoes.outrasInformacoes,
                              isDoubleHeight: true),
                          FieldConfig(
                              label: 'Paciente Curatelado?',
                              hintText: dadosPacienteModel.outrasInformacoes.pacienteCuratelado ? 'Sim' : 'Não',
                              widthFactor: 1,
                              isRadioField: true),
                          FieldConfig(
                              label: 'Técnico de Referência',
                              hintText: dadosPacienteModel.outrasInformacoes.tecnicoReferencia,
                              widthFactor: 1.0,
                              valorInicial: dadosPacienteModel.outrasInformacoes.tecnicoReferencia),
                          FieldConfig(
                              label: 'Outras Informações',
                              hintText: dadosPacienteModel.outrasInformacoes.observacao,
                              widthFactor: 1.0,
                              isDoubleHeight: true,
                              valorInicial: dadosPacienteModel.outrasInformacoes.observacao),
                        ],
                        titulo: 'Outras Informações',
                      );
                    },
                  ),
                ),
              ),
              onTap2: () {
                print("oi");
              },
            ),
          ],
        ),
      ),
      buildCardPaciente(
        context,
        icon: Icons.assignment,
        text: 'Diagnóstico situacional em saúde mental',
        detalhesPaciente: DetalhesPaciente(
          visible: false,
          conteudos: [
            ItemConteudo(
                titulo: 'História do caso e Diagnósticos Multiprofissionais',
                onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Consumer<PacienteProvider>(
                          builder: (context, pacienteProvider, child) {
                            DiagnosticoModal? diagnosticoPacienteModel = pacienteProvider.paciente!.diagnosticoModal;

                            if (diagnosticoPacienteModel?.historiaCasoModel == null) {
                              return Scaffold(
                                backgroundColor: background,
                                body: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Não há diagnóstico multiprofissional cadastrado",
                                          style: TextStyle(fontSize: 20, color: preto1)),
                                      Botaoprincipal(
                                        text: "Adicionar Diagnóstico Multiprofissional",
                                        onPressed: () {
                                          _dialogDiagnosticoMultiprofissional(pacienteProvider);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return FormCategoria(
                                fields: [
                                  FieldConfig(
                                      label: 'História do Caso',
                                      hintText: 'Descreva a história do caso',
                                      valorInicial: diagnosticoPacienteModel?.historiaCasoModel!.historia,
                                      widthFactor: 1.0,
                                      isDoubleHeight: true),
                                  ...diagnosticoPacienteModel!.historiaCasoModel!.diagnosticos!.map((diagnostico) {
                                    return FieldConfig(
                                      label: 'Diagnóstico Multiprofissional',
                                      hintText: 'Diagnósticos Multiprofissionais do paciente',
                                      valorInicial: diagnostico.diagnosticos,
                                      isDoubleHeight: true,
                                      botaoAdicionar: true,
                                      onTapbotaoAdicionar: () {
                                        _dialogUpdateDiagnosticoMulti(
                                            diagnosticoPacienteModel.historiaCasoModel!, pacienteProvider);
                                      },
                                      subtopico:
                                          '${diagnostico.nomeResponsavel} - ${diagnostico.profissaoResponsavel} - ${'CPF:${diagnostico.cpf}'}',
                                      data: formatTimesTamp(diagnostico.dataCriacao),
                                    );
                                  }).toList(),
                                  FieldConfig(
                                      label: 'Imagens do Paciente',
                                      hintText: '',
                                      isImageField: true,
                                      onTapContainer: () async {
                                        await ImagePickerUtil.pegarFoto(context, (foto) async {
                                          await GerenciaPacienteRepository().cadastrarFotoDiagnostico(
                                            diagnosticoPacienteModel.historiaCasoModel!,
                                            foto,
                                            dadosPacienteModel.uidDocumento,
                                          );
                                          Navigator.pop(context);
                                          snackSucesso(context, "Salvo com sucesso");
                                        });
                                      },
                                      images: diagnosticoPacienteModel.historiaCasoModel!.foto),
                                  FieldConfig(
                                    label: "Editar",
                                    hintText: "Editar",
                                    isButtonField: true,
                                    textBotao: "Editar Diagnóstico Multiprofissional",
                                    onTapBotao: () {},
                                  ),
                                ],
                                titulo: 'História do caso e Diagnósticos Multiprofissionais',
                              );
                            }
                          },
                        ),
                      ),
                    ),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Recursos Individuais e Habilidades',
                onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Consumer<PacienteProvider>(
                          builder: (context, pacienteProvider, child) {
                            RecursoIndividuaisModel? recursoIndividuaisModel =
                                pacienteProvider.paciente!.diagnosticoModal?.recursoIndividuaisModel;

                            if (recursoIndividuaisModel?.habilidades == null ||
                                recursoIndividuaisModel!.habilidades!.isEmpty) {
                              return Scaffold(
                                backgroundColor: background,
                                body: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Não há Recursos Individuais cadastrado",
                                          style: TextStyle(fontSize: 20, color: preto1)),
                                      Botaoprincipal(
                                        text: "Adicionar Recursos Individuais",
                                        onPressed: () {
                                          _dialogAdicionarRecursoIndividual(pacienteProvider);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return FormCategoria(
                                fields: [
                                  FieldConfig(
                                      label: 'Recursos Individuais',
                                      hintText: 'Descreva o recursos Individual',
                                      valorInicial: recursoIndividuaisModel.recursoIndividual,
                                      widthFactor: 1.0,
                                      isDoubleHeight: true),
                                  ...recursoIndividuaisModel.habilidades!.map((diagnostico) {
                                    return FieldConfig(
                                      label: 'Habilidades do Paciente',
                                      hintText: 'Habilidades do paciente',
                                      valorInicial: diagnostico.habilidades,
                                      isDoubleHeight: true,
                                      botaoAdicionar: true,
                                      onTapbotaoAdicionar: () {
                                        _dialogAdicionarHabilidade(pacienteProvider, recursoIndividuaisModel);
                                      },
                                      data: formatTimesTamp(diagnostico.dataCriacao),
                                    );
                                  }).toList(),
                                  FieldConfig(
                                    label: "Editar",
                                    hintText: "Editar",
                                    isButtonField: true,
                                    textBotao: "Editar Recursos Individuais",
                                    onTapBotao: () {},
                                  ),
                                ],
                                titulo: 'Recursos Individuais e Habilidades',
                              );
                            }
                          },
                        ),
                      ),
                    ),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Potencialidades',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Consumer<PacienteProvider>(
                        builder: (context, pacienteProvider, child) {
                          PotencialidadeModel? potencialidadeModel =
                              pacienteProvider.paciente!.diagnosticoModal?.potencialidadeModel;

                          if (potencialidadeModel?.potencialidades == null ||
                              potencialidadeModel!.potencialidades!.isEmpty) {
                            return Scaffold(
                              backgroundColor: background,
                              body: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Não há potencialidades cadastradas",
                                        style: TextStyle(fontSize: 20, color: preto1)),
                                    Botaoprincipal(
                                      text: "Adicionar Potencialidades",
                                      onPressed: () {
                                        _dialogAdicionarPotencialidade(pacienteProvider, potencialidadeModel);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return FormCategoria(
                              fields: [
                                ...potencialidadeModel.potencialidades!.map((potencialidade) {
                                  return FieldConfig(
                                    label: 'Potencialidades',
                                    hintText: 'Potencialidades do paciente',
                                    valorInicial: potencialidade.potencialidade,
                                    isDoubleHeight: true,
                                    data: formatTimesTamp(potencialidade.dataCriacao),
                                    botaoAdicionar: true,
                                    onTapbotaoAdicionar: () {
                                      _dialogAdicionarPotencialidade(pacienteProvider, potencialidadeModel);
                                    },
                                  );
                                }).toList(),
                              ],
                              titulo: 'Potencialidades',
                            );
                          }
                        },
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Desejo e Sonhos de Vida',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(label: 'Desejos', hintText: 'Desejos do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Sonhos de Vida', hintText: 'Sonhos de Vida do paciente', widthFactor: 1.0)
                        ],
                        titulo: 'Desejos e Sonhos de Vida',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Dificuldades Pessoais, Coletivas e Estruturais',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(
                              label: 'Recursos Individuais',
                              hintText: 'Recursos Individuais do paciente',
                              widthFactor: 1.0),
                          FieldConfig(label: 'Habilidades', hintText: 'Habilidades do paciente', widthFactor: 1.0)
                        ],
                        titulo: 'Dificuldades Pessoais, Coletivas e Estruturais',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Medicação em Uso',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(label: 'Medicações', hintText: 'Medicações em Uso', widthFactor: 1.0),
                          FieldConfig(label: 'ML', hintText: '', widthFactor: 0.5),
                          FieldConfig(label: 'Uso', hintText: '', widthFactor: 0.5),
                        ],
                        titulo: 'Medicação em Uso',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Doenças Clínicas',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(
                              label: 'Doenças Clínicas', hintText: 'Doenças Clínicas do paciente', widthFactor: 1.0),
                        ],
                        titulo: 'Doenças Clínicas',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Outras Informações',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(
                              label: 'Informações',
                              hintText: 'Informações do paciente',
                              widthFactor: 1.0,
                              isDoubleHeight: true),
                        ],
                        titulo: 'Outras Informações',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
          ],
        ),
      ),
      buildCardPaciente(
        context,
        icon: Icons.flag,
        text: 'Metas de cuidado em saúde mental',
        detalhesPaciente: DetalhesPaciente(
          visible: false,
          conteudos: [
            ItemConteudo(
                titulo: 'Metas a Curto Prazo (Inferiores a 2 meses)',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(label: 'Meta 1', hintText: 'Meta 1 do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Meta 2', hintText: 'Meta 2 do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Meta 3', hintText: 'Meta 3 do paciente', widthFactor: 1.0),
                        ],
                        titulo: 'Metas a Curto Prazo (Inferiores a 2 meses)',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Metas a Médio Prazo (Até 6 meses)',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(label: 'Meta 1', hintText: 'Meta 1 do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Meta 2', hintText: 'Meta 2 do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Meta 3', hintText: 'Meta 3 do paciente', widthFactor: 1.0),
                        ],
                        titulo: 'Metas a Médio Prazo (Até 6 meses)',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Metas a Longo Prazo (Até 12 meses)',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(label: 'Meta 1', hintText: 'Meta 1 do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Meta 2', hintText: 'Meta 2 do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Meta 3', hintText: 'Meta 3 do paciente', widthFactor: 1.0),
                        ],
                        titulo: 'Metas a Longo Prazo (Até 12 meses)',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
          ],
        ),
      ),
      buildCardPaciente(
        context,
        icon: Icons.medical_services,
        text: 'Intervenções em saúde mental',
        detalhesPaciente: DetalhesPaciente(
          visible: true,
          conteudos: [
            ItemConteudo(
                titulo: 'Intervenção - 01/05/2013',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(label: 'Intervenção 1', hintText: 'Intervenção 1 do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Intervenção 2', hintText: 'Intervenção 2 do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Intervenção 3', hintText: 'Intervenção 3 do paciente', widthFactor: 1.0),
                        ],
                        titulo: 'Intervenção - 01/05/2013',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Intervenção - 03/07/2018',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(label: 'Intervenção 1', hintText: 'Intervenção 1 do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Intervenção 2', hintText: 'Intervenção 2 do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Intervenção 3', hintText: 'Intervenção 3 do paciente', widthFactor: 1.0),
                        ],
                        titulo: 'Intervenção - 01/05/2013',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
          ],
        ),
      ),
      buildCardPaciente(
        context,
        icon: Icons.people,
        text: 'Pactuações',
        detalhesPaciente: DetalhesPaciente(
          visible: true,
          conteudos: [
            ItemConteudo(
                titulo: 'Pactuação realizada em 01/05/2013',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(
                              label: 'Paciente Psiquiátrico', hintText: 'Paciente Psiquiátrico', widthFactor: 1.0),
                          FieldConfig(
                              label: 'Responsáveis pela Intervenção',
                              hintText: 'Responsáveis pela Intervenção do paciente',
                              widthFactor: 1.0),
                          FieldConfig(label: 'Prazo', hintText: 'Prazo do paciente', widthFactor: 1.0),
                          FieldConfig(label: 'Família', hintText: 'Família do paciente', widthFactor: 1.0),
                          FieldConfig(
                              label: 'Responsáveis pela Intervenção',
                              hintText: 'Responsáveis pela Intervenção do paciente',
                              widthFactor: 1.0),
                          FieldConfig(label: 'Prazo', hintText: 'Prazo do paciente', widthFactor: 1.0),
                          FieldConfig(
                            label: 'Ata da Pactuação',
                            hintText: '',
                            isImageField: true,
                            // images: [
                            //   const AssetImage(''),
                            // ],
                          ),
                        ],
                        titulo: 'Pactuação realizada em 01/05/2013',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
          ],
        ),
      ),
      buildCardPaciente(
        context,
        icon: Icons.calendar_today,
        text: 'Agenda de Estudo de Caso',
        detalhesPaciente: DetalhesPaciente(
          visible: true,
          conteudos: [
            ItemConteudo(
                titulo: 'Agenda de estudo realizada em 01/05/2013',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(label: 'Data da Reunião', hintText: '00/00/0000', widthFactor: 0.5),
                          FieldConfig(label: 'Pauta', hintText: 'pauta da reuniao', widthFactor: 0.5),
                          FieldConfig(
                              label: 'Quem é necessário participar?',
                              hintText: 'Nomes',
                              widthFactor: 1.0,
                              isDoubleHeight: true),
                        ],
                        titulo: 'Pactuação realizada em 01/05/2013',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
          ],
        ),
      ),
      buildCardPaciente(
        context,
        icon: Icons.assessment,
        text: 'Avaliação do Projeto de Reabilitação Psicossocial',
        detalhesPaciente: DetalhesPaciente(
          visible: true,
          conteudos: [
            ItemConteudo(
                titulo: 'Avaliação Programada do PRP (A CADA 2 MESES) - 01/05/2013',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormCategoria(
                        fields: [
                          FieldConfig(
                              label: 'Intervenção/Pactuação', hintText: 'Nome da Intervenção', widthFactor: 1.0),
                          FieldConfig(label: 'Responsável?', hintText: 'Nomes', widthFactor: 1.0),
                          FieldConfig(
                            label: 'Cumpriu Totalmente',
                            hintText: '',
                            isRadioField: true,
                          ),
                          FieldConfig(
                            label: 'Cumpriu Parcialmente',
                            hintText: '',
                            isRadioField: true,
                          ),
                          FieldConfig(
                            label: 'Não Cumpriu',
                            hintText: '',
                            isRadioField: true,
                          ),
                          FieldConfig(
                              label: 'Observação',
                              hintText: 'Observação do Paciente',
                              widthFactor: 1.0,
                              isDoubleHeight: true),
                          FieldConfig(
                            label: 'Imagens do Paciente',
                            hintText: '',
                            isImageField: true,
                            // images: [
                            //   const AssetImage(''),
                            //   const AssetImage(''),
                            //   const NetworkImage(''),
                            //   const NetworkImage(''),
                            // ],
                          ),
                        ],
                        titulo: 'Avaliação Programada do PRP (A CADA 2 MESES) - 01/05/2013',
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
          ],
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          'Paciente ${dadosPacienteModel.nome}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: listaCard.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return listaCard[index];
                },
              ),
              Botaoprincipal(text: 'Compartilhar Projeto', onPressed: () {}),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardPaciente(BuildContext context,
      {required IconData icon, required String text, required DetalhesPaciente detalhesPaciente}) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetalhesPaciente(conteudos: detalhesPaciente.conteudos, visible: detalhesPaciente.visible))),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange[100],
              ),
              child: Icon(
                icon,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
