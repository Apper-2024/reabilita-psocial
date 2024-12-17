import 'package:reabilita_social/model/paciente/agenda/agenda_model.dart';
import 'package:reabilita_social/model/paciente/avaliacao/avaliacao_model.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_modal.dart';
import 'package:reabilita_social/model/paciente/evolucao/evolucao_model.dart';
import 'package:reabilita_social/model/paciente/intervencoes/intervencoes_model.dart';
import 'package:reabilita_social/model/paciente/metas/meta_model.dart';
import 'package:reabilita_social/model/paciente/pactuacoes/pactuacao_model.dart';

class PacienteModel {
  DadosPacienteModel dadosPacienteModel;
  MetaModel? metasModel;
  IntervencoesModel? intervencoesModel;
  DiagnosticoModal? diagnosticoModal;
  EvolucaoModel? evolucoesModel;
  AgendaModel? listaAgendaModel;
  ListPactuacaoModel? pactuacoesModel;
  AvaliacaoModel? avaliacoesModel;
  PacienteModel({
    required this.dadosPacienteModel,
    this.metasModel,
    this.intervencoesModel,
    this.diagnosticoModal,
    this.evolucoesModel,
    this.listaAgendaModel,
    this.pactuacoesModel,
    this.avaliacoesModel,
  });

  factory PacienteModel.fromMap(Map<String, dynamic> json) {
    return PacienteModel(
      dadosPacienteModel: DadosPacienteModel.fromMap(json['dadosPacienteModel']),
      metasModel: json['metasModel'] != null ? MetaModel.fromMap(json['metasModel']) : null,
      intervencoesModel:
          json['intervencoesModel'] != null ? IntervencoesModel.fromMap(json['intervencoesModel']) : null,
      diagnosticoModal: json['diagnosticoModal'] != null ? DiagnosticoModal.fromMap(json['diagnosticoModal']) : null,
      evolucoesModel: json['evolucoesModel'] != null ? EvolucaoModel.fromMap(json['evolucoesModel']) : null,
      listaAgendaModel: json['listaAgendaModel'] != null ? AgendaModel.fromMap(json['listaAgendaModel']) : null,
      pactuacoesModel: json['pactuacoesModel'] != null ? ListPactuacaoModel.fromMap(json['pactuacoesModel']) : null,
      avaliacoesModel: json['avaliacoesModel'] != null ? AvaliacaoModel.fromMap(json['avaliacoesModel']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dadosPacienteModel': dadosPacienteModel.toMap(),
      'metasModel': metasModel?.toMap(),
      'intervencoesModel': intervencoesModel?.toMap(),
      'diagnosticoModal': diagnosticoModal?.toMap(),
      'evolucoesModel': evolucoesModel?.toMap(),
      'listaAgendaModel': listaAgendaModel?.toMap(),
      'pactuacoesModel': pactuacoesModel?.toMap(),
      'avaliacoesModel': avaliacoesModel?.toMap(),
    };
  }
}
