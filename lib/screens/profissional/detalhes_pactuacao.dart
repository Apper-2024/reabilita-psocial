import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/pactuacoes/pactuacao_model.dart';
import 'package:reabilita_social/provider/paciente_provider.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/screens/profissional/form_categoria.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/formaters/formater_data.dart';

class DetalhesPactuacao extends StatelessWidget {
  final void Function()? onPressed;
  final ListPactuacaoModel pactuacaoModel;
  final String tipo;
  const DetalhesPactuacao({
    super.key,
    this.onPressed,
    required this.pactuacaoModel,
    required this.tipo,
  });

  @override
  Widget build(BuildContext context) {
    final pacienteProvider = Provider.of<PacienteProvider>(context, listen: true);
    DadosPacienteModel pacienteModel = pacienteProvider.paciente!.dadosPacienteModel;
    ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;

    final filteredPactuacoes = pactuacaoModel.pactuacoesModel?.where((p) => p.tipo == tipo).toList();

    return Scaffold(
      backgroundColor: background,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          pacienteModel.nome,
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
            : Expanded(
                child: ListView.builder(
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
