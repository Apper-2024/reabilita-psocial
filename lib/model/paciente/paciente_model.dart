import 'package:reabilita_social/model/paciente/agenda/agenda_model.dart';
import 'package:reabilita_social/model/paciente/avaliacao/avaliacao_model.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_modal.dart';
import 'package:reabilita_social/model/paciente/envolucao/evolucao.dart';
import 'package:reabilita_social/model/paciente/intervencoes/intervencoes_model.dart';
import 'package:reabilita_social/model/paciente/metas/meta_model.dart';
import 'package:reabilita_social/model/paciente/pactuacoes/pactuacao_model.dart';

class PacienteModel {
  DadosPacienteModel dadosPacienteModel;
  List<MetaModel> metas;
  IntervencoesModel intervencoesModel;
  List<AvaliacaoModel> listaAvaliacao;
  DiagnosticoModal diagnosticoModal;
  Evolucao evolucoes;
  AgendaModel listaAgenda;
  List<PactuacaoModel> pactuacoes;

  PacienteModel({
    required this.dadosPacienteModel,
    required this.metas,
    required this.intervencoesModel,
    required this.listaAvaliacao,
    required this.diagnosticoModal,
    required this.evolucoes,
    required this.listaAgenda,
    required this.pactuacoes,
  });

  factory PacienteModel.fromMap(Map<String, dynamic> json) {
    return PacienteModel(
      dadosPacienteModel: DadosPacienteModel.fromMap(json['dadosPacienteModel']),
      metas: (json['metas'] as List).map((i) => MetaModel.fromMap(i)).toList(),
      intervencoesModel: IntervencoesModel.fromMap(json['intervencoesModel']),
      listaAvaliacao: (json['listaAvaliacao'] as List).map((i) => AvaliacaoModel.fromMap(i)).toList(),
      diagnosticoModal: DiagnosticoModal.fromMap(json['diagnosticoModal']),
      evolucoes: Evolucao.fromMap(json['evolucoes']),
      listaAgenda: AgendaModel.fromMap(json['listaAgenda']),
      pactuacoes: (json['pactuacoes'] as List).map((i) => PactuacaoModel.fromMap(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dadosPacienteModel': dadosPacienteModel.toMap(),
      'metas': metas.map((i) => i.toMap()).toList(),
      'intervencoesModel': intervencoesModel.toMap(),
      'listaAvaliacao': listaAvaliacao.map((i) => i.toMap()).toList(),
      'diagnosticoModal': diagnosticoModal.toMap(),
      'evolucoes': evolucoes.toMap(),
      'listaAgenda': listaAgenda.toMap(),
      'pactuacoes': pactuacoes.map((i) => i.toMap()).toList(),
    };
  }
}
