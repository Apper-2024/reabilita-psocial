import 'package:reabilita_social/model/paciente/agenda/agenda_model.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_modal.dart';
import 'package:reabilita_social/model/paciente/evolucao/evolucao_model.dart';
import 'package:reabilita_social/model/paciente/intervencoes/intervencoes_model.dart';
import 'package:reabilita_social/model/paciente/metas/meta_model.dart';

class PacienteModel {
  DadosPacienteModel dadosPacienteModel;
  MetaModel? metas;
  IntervencoesModel? intervencoesModel;
  DiagnosticoModal? diagnosticoModal;
  EvolucaoModel? evolucoes;
  AgendaModel? listaAgenda;

  PacienteModel({
    required this.dadosPacienteModel,
    this.metas,
    this.intervencoesModel,
    this.diagnosticoModal,
    this.evolucoes,
    this.listaAgenda,
  });

  factory PacienteModel.fromMap(Map<String, dynamic> json) {
    return PacienteModel(
      dadosPacienteModel: DadosPacienteModel.fromMap(json['dadosPacienteModel']),
      metas: json['metas'] != null ? MetaModel.fromMap(json['metas']) : null,
      intervencoesModel:
          json['intervencoesModel'] != null ? IntervencoesModel.fromMap(json['intervencoesModel']) : null,
      diagnosticoModal: json['diagnosticoModal'] != null ? DiagnosticoModal.fromMap(json['diagnosticoModal']) : null,
      evolucoes: json['evolucoes'] != null ? EvolucaoModel.fromMap(json['evolucoes']) : null,
      listaAgenda: json['listaAgenda'] != null ? AgendaModel.fromMap(json['listaAgenda']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dadosPacienteModel': dadosPacienteModel.toMap(),
      'metas': metas?.toMap(),
      'intervencoesModel': intervencoesModel?.toMap(),
      'diagnosticoModal': diagnosticoModal?.toMap(),
      'evolucoes': evolucoes?.toMap(),
      'listaAgenda': listaAgenda?.toMap(),
    };
  }
}
