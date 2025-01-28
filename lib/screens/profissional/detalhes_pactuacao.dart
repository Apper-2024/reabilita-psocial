import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reabilita_social/controller/image_controller.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/intervencoes/intervencoes_model.dart';
import 'package:reabilita_social/model/paciente/pactuacoes/pactuacao_model.dart';
import 'package:reabilita_social/provider/paciente_provider.dart';
import 'package:reabilita_social/repository/paciente/gerencia_paciente_repository.dart';
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

class DetalhesPactuacao extends StatelessWidget {
  final void Function()? onPressed;
  final ListPactuacaoModel? pactuacaoModel;
  final String tipo;

  DetalhesPactuacao({
    super.key,
    this.onPressed,
    required this.pactuacaoModel,
    required this.tipo,
  });

  bool _carregando = false;

  Future<void> _dialogEditarPactuacao(PacienteProvider pacienteProvider, ListPactuacaoModel? pactuacoes,
      PactuacaoModel pactuacao, int index, context) async {
    IntervencoesModel? intervencaoModel = pacienteProvider.paciente?.intervencoesModel;

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
                          'Editar Pactuação',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        CustomDropdownButton(
                          hint: 'Selecione o tipo',
                          items: pactuacoesList,
                          dropdownValue: pactuacao.tipo,
                          onChanged: (value) {
                            setStateDialog(() {
                              pactuacao.tipo = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "ex. João",
                          labelText: "Responsável pela pactuação",
                          valorInicial: pactuacao.responsavel,
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            pactuacao.responsavel = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomDropdownButton(
                          hint: 'Selecione a intervenção',
                          items: intervencaoModel?.intervencoesModel.map((e) => e.intervencoes!).toList() ?? [],
                          dropdownValue: pactuacao.intervencao,
                          onChanged: (value) {
                            setStateDialog(() {
                              pactuacao.intervencao = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFieldCustom(
                          tipoTexto: TextInputType.text,
                          hintText: "....",
                          labelText: "Prazo",
                          valorInicial: pactuacao.prazo,
                          senha: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            pactuacao.prazo = value!;
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
                                carregando: _carregando,
                                onPressed: () async {
                                  try {
                                    if (!formKey.currentState!.validate()) {
                                      snackAtencao(context, "Preencha todos os campos");
                                      return;
                                    }
                                    setStateDialog(() {
                                      _carregando = true;
                                    });
                                    formKey.currentState!.save();

                                    pactuacoes?.pactuacoesModel![index] = pactuacao;

                                    await GerenciaPacienteRepository().editarPactuacao(
                                      pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                      pactuacoes!,
                                    );

                                    pacienteProvider.setUpdatePactuacao(pactuacoes);
                                    setStateDialog(() {
                                      _carregando = false;
                                    });
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    snackSucesso(context, "Editado com sucesso");
                                  } catch (e) {
                                    setStateDialog(() {
                                      _carregando = false;
                                    });
                                    snackErro(context, "Erro ao editar pactuação");
                                    Navigator.pop(context);
                                    Navigator.pop(context);

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
    final pacienteProvider = Provider.of<PacienteProvider>(context, listen: true);
    DadosPacienteModel? pacienteModel = pacienteProvider.paciente?.dadosPacienteModel;

    final filteredPactuacoes = pactuacaoModel?.pactuacoesModel?.where((p) => p.tipo == tipo).toList();

    return Scaffold(
      backgroundColor: background,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          pacienteModel?.nome ?? 'Paciente',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        toolbarHeight: 100.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredPactuacoes == null || filteredPactuacoes.isEmpty
            ? const Center(
                child: Text(
                  'Nenhuma pactuação encontrada.',
                  style: TextStyle(fontSize: 18, color: preto1),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: filteredPactuacoes.length,
                itemBuilder: (context, index) {
                  final pactuacao = filteredPactuacoes[index];
                  return InkWell(
                      onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FormCategoria(
                                fields: [
                                  FieldConfig(
                                      label: 'Responsáveis pela Pactuação',
                                      hintText: 'Responsáveis pela Pactuação do paciente',
                                      widthFactor: 1.0,
                                      valorInicial: pactuacao.responsavel),
                                  FieldConfig(
                                      label: 'Prazo',
                                      hintText: 'Prazo do paciente',
                                      widthFactor: 1.0,
                                      valorInicial: pactuacao.prazo),
                                  FieldConfig(
                                      label: 'Intervenção',
                                      hintText: 'Intervenção do paciente',
                                      widthFactor: 1.0,
                                      valorInicial: pactuacao.intervencao),
                                  FieldConfig(
                                      label: 'Tipo da Pactuação',
                                      hintText: 'Tipo da Pactuação',
                                      widthFactor: 1.0,
                                      valorInicial: pactuacao.tipo),
                                  FieldConfig(
                                    label: 'Ata da Pactuação',
                                    hintText: '',
                                    imagem: pactuacao.foto!,
                                    umaImagem: true,
                                    // onDeleteImage: (String urlImagem) async {
                                    //   try {
                                    //     ListPactuacaoModel pactuacaoOri;

                                    //     pactuacaoModel?.pactuacoesModel!.forEach((element) {
                                    //       if (element.foto == urlImagem) {
                                    //         element.foto = '';
                                    //       }
                                    //     });

                                    //     await GerenciaPacienteRepository().deleteImagePactuacao(
                                    //       pactuacaoModel!,
                                    //       pacienteProvider.paciente!.dadosPacienteModel.uidDocumento,
                                    //     );

                                    //     pacienteProvider.setUpdatePactuacao(pactuacaoModel!);

                                    //     snackSucesso(context, "Arquivo deletado com sucesso");
                                    //     Navigator.pop(context);
                                    //   } catch (e) {
                                    //     print("Erro: $e");
                                    //     snackErro(context, "Erro ao deletar arquivo");
                                    //     return;
                                    //   }
                                    // },
                                    // onTapContainer: () async {
                                    //   await ImagePickerUtil.pegarFoto(context, (foto) async {
                                    //     await GerenciaPacienteRepository()
                                    //         .cadastrarImagemPactuacao(dadosPacienteModel, foto!, 'jpg');

                                    //     snackSucesso(context, "Salvo com sucesso");
                                    //     Navigator.pop(context);
                                    //     pacienteProvider.setDadosPaciente(dadosPacienteModel);
                                    //   }, (pdf) async {
                                    //     await GerenciaPacienteRepository()
                                    //         .cadastrarImagemPactuacao(dadosPacienteModel, pdf!, 'pdf');
                                    //     Navigator.pop(context);
                                    //     snackSucesso(context, "Salvo com sucesso");
                                    //   }, true);
                                    // },
                                  ),
                                  FieldConfig(
                                    label: '',
                                    isButtonField: true,
                                    hintText: "",
                                    textBotao: "Editar Intervenção",
                                    onTapBotao: () async {
                                      _dialogEditarPactuacao(
                                          pacienteProvider, pactuacaoModel, pactuacao, index, context);
                                    },
                                  ),
                                ],
                                titulo:
                                    'Pactuação - ${formatTimesTamp(pactuacao.dataCriacao) ?? 'Data não disponível'}',
                              ),
                            ),
                          ),
                      child: ItemLista(conteudo: filteredPactuacoes[index], index: index));
                },
              ),
      ),
    );
  }
}

class ItemLista extends StatelessWidget {
  final PactuacaoModel conteudo;
  final int index;

  const ItemLista({super.key, required this.conteudo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // Permite que o texto ocupe o espaço disponível
            child: Text(
              '${conteudo.tipo!} $index',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange[100],
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: verde1,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
