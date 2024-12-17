import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reabilita_social/controller/image_controller.dart';
import 'package:reabilita_social/enum/enum_meta.dart';
import 'package:reabilita_social/model/paciente/agenda/agenda_model.dart';
import 'package:reabilita_social/model/paciente/avaliacao/avaliacao_model.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/desejo_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_modal.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_multiprofissional_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/doencas_clinicas_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/medicacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/outras_informacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/potencialidade_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/recurso_individuais_model.dart';
import 'package:reabilita_social/model/paciente/intervencoes/intervencoes_model.dart';
import 'package:reabilita_social/model/paciente/metas/meta_model.dart';
import 'package:reabilita_social/model/paciente/pactuacoes/pactuacao_model.dart';
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
import 'package:reabilita_social/widgets/nao_encontrado.dart';
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    formKey.currentState!.save();
                                    diagnosticoMultiprofissionaisModel.dataCriacao = Timestamp.now();

                                    historia.diagnosticos?.add(diagnosticoMultiprofissionaisModel);
                                    await GerenciaPacienteRepository().updateDiagnostico(
                                      historia.diagnosticos,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );
                                    pacienteProvider.setHistoria(historia);
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    formKey.currentState!.save();
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    formKey.currentState!.save();
                                    habilidade.dataCriacao = Timestamp.now();

                                    recursoIndividuaisModel.habilidades?.add(habilidade);

                                    await GerenciaPacienteRepository().cadastraHabilidades(
                                      recursoIndividuaisModel.habilidades!,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdateHabilidade(habilidade);

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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    formKey.currentState!.save();
                                    potencialidade.dataCriacao = Timestamp.now();

                                    // Inicialize a lista de potencialidades se estiver nula
                                    potencialidadeModel ??= PotencialidadeModel(potencialidades: []);
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

  Future<void> _dialogDesejosSonhos(PacienteProvider pacienteProvider) async {
    DesejoModel desejoModel = DesejoModel(
      desejos: '',
      sonhoVida: [],
    );

    SonhoVidaModel sonhoVidaModel = SonhoVidaModel(sonhoVida: '', dataCriacao: Timestamp.now());

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
                          labelText: "Desejo",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            desejoModel.desejos = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. Viajar",
                          labelText: "Sonho de vida",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            sonhoVidaModel.sonhoVida = value!;
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }

                                    formKey.currentState!.save();
                                    sonhoVidaModel.dataCriacao = Timestamp.now();
                                    desejoModel.sonhoVida?.add(sonhoVidaModel);

                                    await GerenciaPacienteRepository().cadastrarDesejosSonhos(
                                      desejoModel,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdateDesejo(desejoModel);

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

  Future<void> _dialogAdicionarSonhos(PacienteProvider pacienteProvider, DesejoModel desejo) async {
    SonhoVidaModel sonhoVidaModel = SonhoVidaModel(sonhoVida: '', dataCriacao: Timestamp.now());

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
                          hintText: "ex. Viajar",
                          labelText: "Sonho de vida",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            sonhoVidaModel.sonhoVida = value!;
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }

                                    formKey.currentState!.save();
                                    sonhoVidaModel.dataCriacao = Timestamp.now();
                                    desejo.sonhoVida?.add(sonhoVidaModel);
                                    await GerenciaPacienteRepository().cadastrarSonhos(
                                      desejo,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdateDesejo(desejo);

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

  Future<void> _dialogAdicionarMedicamento(PacienteProvider pacienteProvider, ListaDeMedicacoes? medicacoes) async {
    MedicacoesModel medicacoesModel =
        MedicacoesModel(frequencia: "", medicacao: "", quantidade: "", via: "", dataCriacao: Timestamp.now());

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
                          hintText: "ex. remédio tal",
                          labelText: "Nome da medicação",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            medicacoesModel.medicacao = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. Viajar",
                          labelText: "Sonho de vida",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            medicacoesModel.frequencia = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. 3 vezes ao dia",
                          labelText: "Quantidade",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            medicacoesModel.quantidade = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. Oral",
                          labelText: "Via de administração",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            medicacoesModel.via = value!;
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }

                                    formKey.currentState!.save();
                                    medicacoesModel.dataCriacao = Timestamp.now();

                                    medicacoes ??= ListaDeMedicacoes(medicacoes: []);

                                    medicacoes!.medicacoes.add(medicacoesModel);
                                    print("Medicações: ${medicacoes!.medicacoes}");

                                    await GerenciaPacienteRepository().cadastrarMedicacoes(
                                      medicacoes!,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdateMedicacoes(medicacoes!);

                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    print("Erro: $e");
                                    snackErro(context, "Erro ao cadastrar medicações");
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

  Future<void> _dialogAdicionarDoencaClinica(PacienteProvider pacienteProvider, ListaDoencaClinica? doencas) async {
    DoencaClinicaModel doencaClinicaModel = DoencaClinicaModel(
      doencaClinica: "",
      dataCriacao: Timestamp.now(),
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
                          'Cadastro de Doença Clínica',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. Depressão",
                          labelText: "Doença Clínica",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            doencaClinicaModel.doencaClinica = value!;
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }

                                    formKey.currentState!.save();
                                    doencaClinicaModel.dataCriacao = Timestamp.now();

                                    doencas ??= ListaDoencaClinica(doencasClinicas: []);

                                    doencas!.doencasClinicas?.add(doencaClinicaModel);

                                    await GerenciaPacienteRepository().cadastrarDoenca(
                                      doencas!,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdateDoenca(doencas!);

                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    print("Erro: $e");
                                    snackErro(context, "Erro ao cadastrar doença clínica");
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

  Future<void> _dialogAdicionarOutrasInformacoes(
      PacienteProvider pacienteProvider, ListaOutrasInformacoes? outrasInformacoes) async {
    OutrasInformacoesDiagnosticoModel outrasInformacoesModel =
        OutrasInformacoesDiagnosticoModel(dataCriacao: Timestamp.now(), outrasInformacoes: '');

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
                          'Cadastro de Doença Clínica',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: ".......",
                          labelText: "Outras Informações",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            outrasInformacoesModel.outrasInformacoes = value!;
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }

                                    formKey.currentState!.save();
                                    outrasInformacoesModel.dataCriacao = Timestamp.now();

                                    outrasInformacoes ??= ListaOutrasInformacoes(listaOutrasInformacoes: []);

                                    outrasInformacoes!.listaOutrasInformacoes?.add(outrasInformacoesModel);

                                    await GerenciaPacienteRepository().cadastrarOutrasInformacoes(
                                      outrasInformacoes!,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdateOutrasInformacoes(outrasInformacoes!);

                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    print("Erro: $e");
                                    snackErro(context, "Erro ao cadastrar doença clínica");
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

  Future<void> _dialogAdicionaMeta(PacienteProvider pacienteProvider, MetaModel? meta) async {
    MetaList metaModel = MetaList(dataCriacao: Timestamp.now(), meta: '', tipo: null);

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
                          'Cadastro de Doença Clínica',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. Fazer tal coisa",
                          labelText: "Meta",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            metaModel.meta = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomDropdownButton(
                          hint: "Tipo de meta",
                          dropdownValue: metaModel.tipo,
                          items: EnumMeta.values.map((e) => e.toString().split('.').last).toList(),
                          onChanged: (value) {
                            setStateDialog(() {
                              metaModel.tipo = value!;
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    formKey.currentState!.save();
                                    if (metaModel.tipo == null) {
                                      snackAtencao(context, "Selecione o tipo de meta");
                                      return;
                                    }

                                    metaModel.dataCriacao = Timestamp.now();

                                    meta ??= MetaModel(metas: []);

                                    meta!.metas?.add(metaModel);

                                    await GerenciaPacienteRepository().cadastrarMetas(
                                      meta!,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdateMeta(meta!);

                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    print("Erro: $e");
                                    snackErro(context, "Erro ao cadastrar Metas");
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

  Future<void> _dialogAdicionaIntervencao(PacienteProvider pacienteProvider, IntervencoesModel? intervencao) async {
    ListIntervencoesModel intervencaoModel = ListIntervencoesModel(
        dataCriacao: Timestamp.now(), intervencoes: '', meta: "", nomeResponsavel: '', prazo: '', problema: '');

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
                          'Cadastro de Intervenções',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. Acorreu tal coisa",
                          labelText: "Problema",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            intervencaoModel.problema = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "....",
                          labelText: "Intervenção",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            intervencaoModel.intervencoes = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. João",
                          labelText: "Responsavel pela intervenção",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            intervencaoModel.nomeResponsavel = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. Melhorar tal coisa",
                          labelText: "Meta",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            intervencaoModel.meta = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. 11 dias",
                          labelText: "Prazo",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            intervencaoModel.prazo = value!;
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    formKey.currentState!.save();

                                    intervencaoModel.dataCriacao = Timestamp.now();

                                    intervencao ??= IntervencoesModel(intervencoesModel: []);

                                    intervencao!.intervencoesModel?.add(intervencaoModel);

                                    await GerenciaPacienteRepository().cadastrarIntervencao(
                                      intervencao!,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdateIntervencao(intervencao!);

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    print("Erro: $e");
                                    snackErro(context, "Erro ao cadastrar intervenção");
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

  Future<void> _dialogAdicionaPactuacao(PacienteProvider pacienteProvider, ListPactuacaoModel? pactuacao) async {
    PactuacaoModel pactuacaoModel = PactuacaoModel(
      prazo: '',
      responsavel: '',
      dataCriacao: Timestamp.now(),
      familia: '',
      foto: '',
      paciente: '',
      responsavelPactuacao: '',
    );
    Uint8List? image;

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
                          'Cadastro de Pactuação',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. João",
                          labelText: "Responsavel pela pactuação",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            pactuacaoModel.responsavelPactuacao = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. Paulo",
                          labelText: "Responsavel pelo paciente",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            pactuacaoModel.responsavel = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "....",
                          labelText: "Prazo",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            pactuacaoModel.prazo = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: ".....",
                          labelText: "Família",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            pactuacaoModel.familia = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          children: [
                            if (image != null)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.22,
                                height: MediaQuery.of(context).size.width * 0.22,
                                color: Colors.grey[300],
                                child: Image.memory(image!, fit: BoxFit.cover),
                              ),
                            if (image == null)
                              InkWell(
                                onTap: () {
                                  ImagePickerUtil.pegarFoto(context, (foto) {
                                    setStateDialog(() {
                                      image = foto;
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
                                    if (image == null) {
                                      snackAtencao(context, "Selecione uma ATA");
                                      return;
                                    }

                                    formKey.currentState!.save();

                                    pactuacaoModel.dataCriacao = Timestamp.now();
                                    pactuacaoModel.paciente = pacienteProvider.paciente!.dadosPacienteModel.nome;

                                    pactuacao ??= ListPactuacaoModel(pactuacoesModel: []);

                                    await GerenciaPacienteRepository().cadastrarPactuacao(
                                        pactuacao!,
                                        pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                        pactuacaoModel,
                                        image!);

                                    pacienteProvider.setUpdatePactuacao(pactuacao!);

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    print("Erro: $e");
                                    snackErro(context, "Erro ao cadastrar intervenção");
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

  Future<void> _dialogAdicionaEstudoCaso(PacienteProvider pacienteProvider, AgendaModel? agenda) async {
    AgendaList agendaList = AgendaList(dataCriacao: Timestamp.now(), participantes: "", pauta: "");

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
                          'Cadastro de Agenda de Estudos',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. João, José",
                          labelText: "Participantes",
                          maxLines: 5,
                          minLines: 1,
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            agendaList.participantes = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: ".......",
                          labelText: "Pauta",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            agendaList.pauta = value!;
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
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }

                                    formKey.currentState!.save();

                                    agendaList.dataCriacao = Timestamp.now();

                                    agenda ??= AgendaModel(listaAgendaModel: []);

                                    agenda!.listaAgendaModel?.add(agendaList);

                                    await GerenciaPacienteRepository().cadastrarAgenda(
                                      agenda!,
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    );

                                    pacienteProvider.setUpdateAgenda(agenda!);

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    print("Erro: $e");
                                    snackErro(context, "Erro ao cadastrar intervenção");
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

  Future<void> _dialogAvaliacaoProgramada(PacienteProvider pacienteProvider, AvaliacaoModel? avaliacao) async {
    ListAvaliacao avaliacaoModel = ListAvaliacao(
        dataCriacao: Timestamp.now(), avaliacao: null, intervencao: '', responsavel: '', observacao: "", foto: "");

    Uint8List? image;

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
                          'Cadastro de Agenda de Estudos',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: ".......",
                          labelText: "Responsavel",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            avaliacaoModel.responsavel = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: ".......",
                          labelText: "Intervenção",
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            avaliacaoModel.intervencao = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomDropdownButton(
                          hint: 'Avaliação',
                          items: prazo,
                          onChanged: (value) {
                            setStateDialog(() {
                              avaliacaoModel.avaliacao = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: ".......",
                          labelText: "Observações",
                          senha: false,
                          maxLines: 5,
                          minLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            avaliacaoModel.observacao = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          children: [
                            if (image != null)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.22,
                                height: MediaQuery.of(context).size.width * 0.22,
                                color: Colors.grey[300],
                                child: Image.memory(image!, fit: BoxFit.cover),
                              ),
                            if (image == null)
                              InkWell(
                                onTap: () {
                                  ImagePickerUtil.pegarFoto(context, (foto) {
                                    setStateDialog(() {
                                      image = foto;
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
                                    if (image == null) {
                                      snackAtencao(context, "Selecione uma imagem");
                                      return;
                                    }

                                    formKey.currentState!.save();
                                    if (avaliacaoModel.avaliacao == null) {
                                      snackAtencao(context, "Selecione uma avaliação");
                                      return;
                                    }
                                    avaliacaoModel.dataCriacao = Timestamp.now();

                                    avaliacao ??= AvaliacaoModel(avaliacoesModel: []);

                                    await GerenciaPacienteRepository().cadastrarAvaliacao(
                                        avaliacao!,
                                        pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                        avaliacaoModel,
                                        image!);

                                    pacienteProvider.setUpdateAvaliacoes(avaliacao!);

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    snackSucesso(context, "Cadastrado com sucesso");
                                  } catch (e) {
                                    print("Erro: $e");
                                    snackErro(context, "Erro ao cadastrar intervenção");
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
                              return NaoEncontrado(
                                titulo: "Não há diagnóstico multiprofissional cadastrado",
                                textButton: "Adicionar Diagnóstico Multiprofissional",
                                onPressed: () => _dialogDiagnosticoMultiprofissional(pacienteProvider),
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
                                  }),
                                  FieldConfig(
                                      label: 'Imagens do Paciente',
                                      hintText: '',
                                      isImageField: true,
                                      onTapContainer: () async {
                                        await ImagePickerUtil.pegarFoto(context, (foto) async {
                                          final urlImagem = await GerenciaPacienteRepository().cadastrarFotoDiagnostico(
                                            diagnosticoPacienteModel.historiaCasoModel!,
                                            foto,
                                            dadosPacienteModel.uidDocumento,
                                          );
                                          // diagnosticoPacienteModel.historiaCasoModel!.foto!.add(urlImagem);
                                          // pacienteProvider.setHistoria(diagnosticoPacienteModel.historiaCasoModel!);

                                          Navigator.pop(context);
                                          snackSucesso(context, "Salvo com sucesso");
                                        });
                                      },
                                      images: diagnosticoPacienteModel.historiaCasoModel!.foto),
                                  // FieldConfig(
                                  //   label: "Editar",
                                  //   hintText: "Editar",
                                  //   isButtonField: true,
                                  //   textBotao: "Editar Diagnóstico Multiprofissional",
                                  //   onTapBotao: () {},
                                  // ),
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
                              return NaoEncontrado(
                                titulo: "Não há Recursos Individuais cadastrado",
                                textButton: "Adicionar Recursos Individuais",
                                onPressed: () => _dialogAdicionarRecursoIndividual(pacienteProvider),
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
                                  }),
                                  // FieldConfig(
                                  //   label: "Editar",
                                  //   hintText: "Editar",
                                  //   isButtonField: true,
                                  //   textBotao: "Editar Recursos Individuais",
                                  //   onTapBotao: () {},
                                  // ),
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
                            return NaoEncontrado(
                              titulo: "Não há potencialidades cadastradas",
                              textButton: "Adicionar Potencialidades",
                              onPressed: () => _dialogAdicionarPotencialidade(pacienteProvider, potencialidadeModel),
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
                                }),
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
                onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Consumer<PacienteProvider>(
                          builder: (context, pacienteProvider, child) {
                            DesejoModel? desejoModel = pacienteProvider.paciente!.diagnosticoModal?.desejoModel;

                            if (desejoModel == null ||
                                desejoModel.sonhoVida == null ||
                                desejoModel.sonhoVida!.isEmpty) {
                              return NaoEncontrado(
                                titulo: "Não há desejos cadastrados!",
                                textButton: "Adicionar Desejos e Sonhos de vida",
                                onPressed: () => _dialogDesejosSonhos(pacienteProvider),
                              );
                            } else {
                              return FormCategoria(
                                fields: [
                                  FieldConfig(
                                      label: 'Desejos',
                                      hintText: 'Desejos do paciente',
                                      isDoubleHeight: true,
                                      valorInicial: desejoModel.desejos),
                                  ...desejoModel.sonhoVida!.map((sonhos) {
                                    return FieldConfig(
                                      label: 'Sonhos',
                                      hintText: 'Sonho do paciente',
                                      valorInicial: sonhos.sonhoVida,
                                      isDoubleHeight: true,
                                      data: formatTimesTamp(sonhos.dataCriacao),
                                      botaoAdicionar: true,
                                      onTapbotaoAdicionar: () {
                                        _dialogAdicionarSonhos(pacienteProvider, desejoModel);
                                      },
                                    );
                                  }),
                                ],
                                titulo: 'Potencialidades',
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
                      builder: (context) => Consumer<PacienteProvider>(
                        builder: (context, pacienteProvider, child) {
                          ListaDeMedicacoes? medicacoesModel =
                              pacienteProvider.paciente!.diagnosticoModal?.medicacoesModel;

                          if (medicacoesModel == null || medicacoesModel.medicacoes.isEmpty) {
                            return NaoEncontrado(
                                titulo: "Não há medicações em uso!",
                                textButton: "Adicionar Medicamentos em Uso",
                                onPressed: () => _dialogAdicionarMedicamento(pacienteProvider, medicacoesModel));
                          } else {
                            return FormCategoria(
                              fields: [
                                ...medicacoesModel.medicacoes.map((medicacao) {
                                  return [
                                    FieldConfig(
                                      label: 'Medicações',
                                      hintText: 'Medicações em Uso',
                                      widthFactor: 1.0,
                                      valorInicial: medicacao.medicacao,
                                    ),
                                    FieldConfig(
                                        label: 'ML',
                                        hintText: medicacao.quantidade!,
                                        widthFactor: 0.5,
                                        valorInicial: medicacao.quantidade),
                                    FieldConfig(
                                      label: 'Uso',
                                      hintText: medicacao.via!,
                                      widthFactor: 0.5,
                                      valorInicial: medicacao.via,
                                    ),
                                  ];
                                }).expand((element) => element),
                                FieldConfig(
                                    hintText: '',
                                    label: '',
                                    textBotao: "Adicionar Medicamento",
                                    onTapBotao: () {
                                      _dialogAdicionarMedicamento(pacienteProvider, medicacoesModel);
                                    },
                                    isButtonField: true),
                              ],
                              titulo: 'Medicações em Uso',
                            );
                          }
                        },
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Doenças Clínicas',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Consumer<PacienteProvider>(
                        builder: (context, pacienteProvider, child) {
                          ListaDoencaClinica? doencaClinicaModel =
                              pacienteProvider.paciente!.diagnosticoModal?.doencasClinicasModel;

                          if (doencaClinicaModel == null || doencaClinicaModel.doencasClinicas!.isEmpty) {
                            return NaoEncontrado(
                                titulo: "Não há doenças clínicas cadastradas",
                                textButton: "Adicionar Doenças Clínicas",
                                onPressed: () => _dialogAdicionarDoencaClinica(pacienteProvider, doencaClinicaModel));
                          } else {
                            return FormCategoria(
                              fields: [
                                ...doencaClinicaModel.doencasClinicas!.map((doenca) {
                                  return [
                                    FieldConfig(
                                      label: 'Doença Clínica',
                                      hintText: doenca.doencaClinica!,
                                      isDoubleHeight: true,
                                      valorInicial: doenca.doencaClinica,
                                      data: formatTimesTamp(doenca.dataCriacao),
                                      botaoAdicionar: true,
                                      onTapbotaoAdicionar: () {
                                        _dialogAdicionarDoencaClinica(pacienteProvider, doencaClinicaModel);
                                      },
                                    ),
                                  ];
                                }).expand((element) => element),
                              ],
                              titulo: 'Doenças Clínicas',
                            );
                          }
                        },
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
            ItemConteudo(
                titulo: 'Outras Informações',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Consumer<PacienteProvider>(
                        builder: (context, pacienteProvider, child) {
                          ListaOutrasInformacoes? outrasInformacoesModel =
                              pacienteProvider.paciente!.diagnosticoModal?.outrasInformacoesModel;

                          if (outrasInformacoesModel == null ||
                              outrasInformacoesModel.listaOutrasInformacoes!.isEmpty) {
                            return NaoEncontrado(
                                titulo: "Não há outras informações cadastradas",
                                textButton: "Adicionar Outras Informações",
                                onPressed: () =>
                                    _dialogAdicionarOutrasInformacoes(pacienteProvider, outrasInformacoesModel));
                          } else {
                            return FormCategoria(
                              fields: [
                                ...outrasInformacoesModel.listaOutrasInformacoes!.map((doenca) {
                                  return [
                                    FieldConfig(
                                      label: 'Informações',
                                      hintText: doenca.outrasInformacoes!,
                                      isDoubleHeight: true,
                                      valorInicial: doenca.outrasInformacoes,
                                      data: formatTimesTamp(doenca.dataCriacao),
                                      botaoAdicionar: true,
                                      maxLine: 5,
                                      minLine: 1,
                                      onTapbotaoAdicionar: () {
                                        _dialogAdicionarOutrasInformacoes(pacienteProvider, outrasInformacoesModel);
                                      },
                                    ),
                                  ];
                                }).expand((element) => element),
                              ],
                              titulo: 'Doenças Clínicas',
                            );
                          }
                        },
                      ),
                    )),
                onTap2: () {
                  print("oi");
                }),
          ],
        ),
      ),
      Consumer<PacienteProvider>(
        builder: (context, value, child) {
          MetaModel? metaModel = value.paciente!.metasModel;
          return buildCardPaciente(
            context,
            icon: Icons.flag,
            text: 'Metas de cuidado em saúde mental',
            detalhesPaciente: DetalhesPaciente(
              visible: true,
              onPressed: () {
                _dialogAdicionaMeta(pacienteProvider, pacienteProvider.paciente!.metasModel);
              },
              conteudos: [
                ItemConteudo(
                  titulo: 'Metas a Curto Prazo (Inferiores a 2 meses)',
                  onTap: () {
                    List<MetaList>? listaCurta =
                        metaModel?.metas!.where((element) => element.tipo == EnumMeta.curta.name).toList();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => listaCurta!.isEmpty
                            ? const NaoEncontrado(
                                titulo: "Metas a Curto Prazo Não Encontradas",
                              )
                            : FormCategoria(
                                fields: [
                                  ...listaCurta.map((meta) {
                                    return FieldConfig(
                                      label: 'Meta',
                                      hintText: meta.meta!,
                                      widthFactor: 1.0,
                                      valorInicial: meta.meta,
                                      data: formatTimesTamp(meta.dataCriacao),
                                    );
                                  }),
                                ],
                                titulo: 'Metas a Curto Prazo (Inferiores a 2 meses)',
                              ),
                      ),
                    );
                  },
                  onTap2: () {
                    print('l');
                  },
                ),
                ItemConteudo(
                  titulo: 'Metas a Médio Prazo (Até 6 meses)',
                  onTap: () {
                    List<MetaList>? listaMedia =
                        metaModel?.metas!.where((element) => element.tipo == EnumMeta.media.name).toList();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => listaMedia!.isEmpty
                            ? const NaoEncontrado(
                                titulo: "Metas a Médio Prazo Não Encontradas",
                              )
                            : FormCategoria(
                                fields: [
                                  ...listaMedia.map((meta) {
                                    return FieldConfig(
                                      label: 'Meta',
                                      hintText: meta.meta!,
                                      widthFactor: 1.0,
                                      valorInicial: meta.meta,
                                      data: formatTimesTamp(meta.dataCriacao),
                                    );
                                  }),
                                ],
                                titulo: 'Metas a Médio Prazo (Até 6 meses)',
                              ),
                      ),
                    );
                  },
                  onTap2: () {
                    print('l');
                  },
                ),
                ItemConteudo(
                  titulo: 'Metas a Longo Prazo (Até 12 meses)',
                  onTap: () {
                    List<MetaList>? listaLonga =
                        metaModel?.metas!.where((element) => element.tipo == EnumMeta.longa.name).toList();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => listaLonga!.isEmpty
                            ? const NaoEncontrado(
                                titulo: "Metas a Longo Prazo Não Encontradas",
                              )
                            : FormCategoria(
                                fields: [
                                  ...listaLonga.map((meta) {
                                    return FieldConfig(
                                      label: 'Meta',
                                      hintText: meta.meta!,
                                      widthFactor: 1.0,
                                      valorInicial: meta.meta,
                                      data: formatTimesTamp(meta.dataCriacao),
                                    );
                                  }),
                                ],
                                titulo: 'Metas a Longo Prazo (Até 12 meses)',
                              ),
                      ),
                    );
                  },
                  onTap2: () {
                    print('l');
                  },
                ),
              ],
            ),
          );
        },
      ),
      Consumer<PacienteProvider>(
        builder: (context, value, child) {
          IntervencoesModel? intervencoesModel = value.paciente!.intervencoesModel;
          return buildCardPaciente(
            context,
            icon: Icons.medical_services,
            text: 'Intervenções em saúde mental',
            detalhesPaciente: DetalhesPaciente(
              visible: true,
              onPressed: () {
                _dialogAdicionaIntervencao(pacienteProvider, intervencoesModel);
              },
              conteudos: [
                if (intervencoesModel == null || intervencoesModel.intervencoesModel?.isEmpty == true)
                  ItemConteudo(
                    titulo: 'Nenhum Intervenção Cadastrada',
                    onTap: () {
                      _dialogAdicionaIntervencao(pacienteProvider, intervencoesModel);
                    },
                    onTap2: () {
                      print("oi");
                    },
                  )
                else
                  ...?intervencoesModel.intervencoesModel?.map((e) => ItemConteudo(
                        titulo: 'Intervenção - ${formatTimesTamp(e.dataCriacao) ?? 'Data não disponível'}',
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FormCategoria(
                              fields: [
                                FieldConfig(
                                  label: 'Problema',
                                  hintText: e.problema ?? 'Problema',
                                  valorInicial: e.problema,
                                  widthFactor: 1.0,
                                ),
                                FieldConfig(
                                  label: 'Intervenção',
                                  hintText: e.intervencoes ?? 'intervencoes',
                                  valorInicial: e.intervencoes,
                                  data: formatTimesTamp(e.dataCriacao),
                                  widthFactor: 1.0,
                                ),
                                FieldConfig(
                                  label: 'Responsável',
                                  hintText: e.nomeResponsavel ?? '',
                                  valorInicial: e.nomeResponsavel,
                                  widthFactor: 1.0,
                                ),
                                FieldConfig(
                                  label: 'Meta',
                                  hintText: e.meta ?? '',
                                  valorInicial: e.meta,
                                  widthFactor: 0.5,
                                ),
                                FieldConfig(
                                  label: 'Meta',
                                  hintText: e.prazo ?? '',
                                  valorInicial: e.prazo,
                                  widthFactor: 0.5,
                                ),
                              ],
                              titulo: 'Intervenção - ${formatTimesTamp(e.dataCriacao) ?? 'Data não disponível'}',
                            ),
                          ),
                        ),
                        onTap2: () {
                          print("oi");
                        },
                      )),
              ],
            ),
          );
        },
      ),
      Consumer<PacienteProvider>(
        builder: (context, value, child) {
          ListPactuacaoModel? pactuacaoModel = value.paciente!.pactuacoesModel;

          return buildCardPaciente(
            context,
            icon: Icons.people,
            text: 'Pactuações',
            detalhesPaciente: DetalhesPaciente(
              visible: true,
              onPressed: () {
                _dialogAdicionaPactuacao(pacienteProvider, pactuacaoModel);
              },
              conteudos: [
                if (pactuacaoModel == null || pactuacaoModel.pactuacoesModel?.isEmpty == true)
                  ItemConteudo(
                    titulo: 'Nenhuma pactuação cadastrada',
                    onTap: () {
                      _dialogAdicionaPactuacao(pacienteProvider, pactuacaoModel);
                    },
                    onTap2: () {
                      print("oi");
                    },
                  )
                else
                  ...?pactuacaoModel.pactuacoesModel?.map((pactuacao) => ItemConteudo(
                        titulo: 'Pactuação - ${formatTimesTamp(pactuacao.dataCriacao) ?? 'Data não disponível'}',
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FormCategoria(
                              fields: [
                                FieldConfig(
                                    label: 'Paciente Psiquiátrico',
                                    hintText: 'Paciente Psiquiátrico',
                                    valorInicial: pactuacao.paciente,
                                    widthFactor: 1.0),
                                FieldConfig(
                                    label: 'Responsáveis pela Intervenção',
                                    hintText: 'Responsáveis pela Intervenção do paciente',
                                    widthFactor: 1.0,
                                    valorInicial: pactuacao.responsavel),
                                FieldConfig(
                                    label: 'Prazo',
                                    hintText: 'Prazo do paciente',
                                    widthFactor: 1.0,
                                    valorInicial: pactuacao.prazo),
                                FieldConfig(
                                    label: 'Família',
                                    hintText: 'Família do paciente',
                                    widthFactor: 1.0,
                                    valorInicial: pactuacao.familia),
                                FieldConfig(
                                    label: 'Responsáveis pela Intervenção',
                                    hintText: 'Responsáveis pela Intervenção do paciente',
                                    widthFactor: 1.0,
                                    valorInicial: pactuacao.responsavelPactuacao),
                                FieldConfig(
                                  label: 'Ata da Pactuação',
                                  hintText: '',
                                  imagem: pactuacao.foto!,
                                  umaImagem: true,
                                ),
                              ],
                              titulo: 'Pactuação - ${formatTimesTamp(pactuacao.dataCriacao) ?? 'Data não disponível'}',
                            ),
                          ),
                        ),
                        onTap2: () {
                          print("oi");
                        },
                      )),
              ],
            ),
          );
        },
      ),
      Consumer<PacienteProvider>(
        builder: (context, value, child) {
          AgendaModel? agendaModel = value.paciente!.listaAgendaModel;

          return buildCardPaciente(
            context,
            icon: Icons.people,
            text: 'Agenda de Estudo de Caso',
            detalhesPaciente: DetalhesPaciente(
              visible: true,
              onPressed: () {
                _dialogAdicionaEstudoCaso(pacienteProvider, agendaModel);
              },
              conteudos: [
                if (agendaModel == null || agendaModel.listaAgendaModel?.isEmpty == true)
                  ItemConteudo(
                    titulo: 'Nenhuma agenda cadastrada',
                    onTap: () {
                      _dialogAdicionaEstudoCaso(pacienteProvider, agendaModel);
                    },
                    onTap2: () {
                      print("oi");
                    },
                  )
                else
                  ...?agendaModel.listaAgendaModel?.map((agendas) => ItemConteudo(
                        titulo: 'Agenda de estudo - ${formatTimesTamp(agendas.dataCriacao) ?? 'Data não disponível'}',
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FormCategoria(
                              fields: [
                                FieldConfig(
                                    label: 'Data da Reunião',
                                    hintText: formatTimesTamp(agendas.dataCriacao)!,
                                    widthFactor: 0.5,
                                    valorInicial: formatTimesTamp(agendas.dataCriacao)),
                                FieldConfig(
                                    label: 'Pauta',
                                    hintText: 'pauta da reuniao',
                                    widthFactor: 0.5,
                                    valorInicial: formatTimesTamp(agendas.dataCriacao)),
                                FieldConfig(
                                    label: 'Quem é necessário participar?',
                                    hintText: 'Nomes',
                                    widthFactor: 1.0,
                                    isDoubleHeight: true,
                                    valorInicial: formatTimesTamp(agendas.dataCriacao)),
                              ],
                              titulo:
                                  'Agenda de estudo - ${formatTimesTamp(agendas.dataCriacao) ?? 'Data não disponível'}',
                            ),
                          ),
                        ),
                        onTap2: () {
                          print("oi");
                        },
                      )),
              ],
            ),
          );
        },
      ),
      Consumer<PacienteProvider>(builder: (context, value, child) {
        AvaliacaoModel? avaliacaoModel = value.paciente!.avaliacoesModel;
        return buildCardPaciente(
          context,
          icon: Icons.assessment,
          text: 'Avaliação do Projeto de Reabilitação Psicossocial',
          detalhesPaciente: DetalhesPaciente(
            visible: true,
            onPressed: () {
              _dialogAvaliacaoProgramada(pacienteProvider, avaliacaoModel);
            },
            conteudos: [
              if (avaliacaoModel == null || avaliacaoModel.avaliacoesModel?.isEmpty == true)
                ItemConteudo(
                  titulo: 'Nenhuma agenda cadastrada',
                  onTap: () {
                    _dialogAvaliacaoProgramada(pacienteProvider, avaliacaoModel);
                  },
                  onTap2: () {
                    print("oi");
                  },
                )
              else
                ...?avaliacaoModel.avaliacoesModel?.map((avaliacoes) => ItemConteudo(
                      titulo:
                          'Avaliação Programada do PRP (A CADA 2 MESES) - ${formatTimesTamp(avaliacoes.dataCriacao)}',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FormCategoria(
                            fields: [
                              FieldConfig(
                                  label: 'Intervenção/Pactuação',
                                  hintText: 'Nome da Intervenção',
                                  widthFactor: 1.0,
                                  valorInicial: avaliacoes.intervencao),
                              FieldConfig(
                                  label: 'Responsável?',
                                  hintText: 'Nomes',
                                  widthFactor: 1.0,
                                  valorInicial: avaliacoes.responsavel),
                              FieldConfig(
                                  label: 'Avaliação dos Prazos do Projeto',
                                  hintText: '',
                                  isRadioField: true,
                                  valorInicial: avaliacoes.intervencao),
                              FieldConfig(
                                  label: 'Observação',
                                  hintText: 'Observação do Paciente',
                                  widthFactor: 1.0,
                                  valorInicial: avaliacoes.observacao,
                                  isDoubleHeight: true),
                              FieldConfig(
                                label: 'Imagens do Paciente',
                                hintText: '',
                                imagem: avaliacoes.foto,
                                umaImagem: true,
                              ),
                            ],
                            titulo:
                                'Agenda de estudo - ${formatTimesTamp(avaliacoes.dataCriacao) ?? 'Data não disponível'}',
                          ),
                        ),
                      ),
                      onTap2: () {
                        print("oi");
                      },
                    )),
            ],
          ),
        );
      })
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
              builder: (context) => DetalhesPaciente(
                  conteudos: detalhesPaciente.conteudos,
                  visible: detalhesPaciente.visible,
                  onPressed: detalhesPaciente.onPressed))),
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
