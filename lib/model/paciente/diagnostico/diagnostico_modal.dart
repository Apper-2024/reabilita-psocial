import 'package:reabilita_social/model/paciente/diagnostico/desejo_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_multiprofissional_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/doencas_clinicas_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/medicacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/outras_informacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/potencialidade_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/recurso_individuais_model.dart';

class DiagnosticoModal {
  DesejoModel desejoModel;
  DiagnosticoMultiprofissionaisModel diagnosticoMultiprofissionais;
  DoencaClinicaModel doencasClinicas;
  MedicacoesModel medicacoesModel;
  OutrasInformacoesModel outrasInformacoesModel;
  PotencialidadeModel potencialidadeModel;
  RecursoIndividuaisModel recursoIndividuaisModel;

  DiagnosticoModal({
    required this.desejoModel,
    required this.diagnosticoMultiprofissionais,
    required this.doencasClinicas,
    required this.medicacoesModel,
    required this.outrasInformacoesModel,
    required this.potencialidadeModel,
    required this.recursoIndividuaisModel,
  });

  factory DiagnosticoModal.fromMap(Map<String, dynamic> json) {
    return DiagnosticoModal(
      desejoModel: DesejoModel.fromMap(json['desejoModel']),
      diagnosticoMultiprofissionais: DiagnosticoMultiprofissionaisModel.fromMap(json['diagnosticoMultiprofissionais']),
      doencasClinicas: DoencaClinicaModel.fromMap(json['doencasClinicas']),
      medicacoesModel: MedicacoesModel.fromMap(json['medicacoesModel']),
      outrasInformacoesModel: OutrasInformacoesModel.fromMap(json['outrasInformacoesModel']),
      potencialidadeModel: PotencialidadeModel.fromMap(json['potencialidadeModel']),
      recursoIndividuaisModel: RecursoIndividuaisModel.fromMap(json['recursoIndividuaisModel']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'desejoModel': desejoModel.toMap(),
      'diagnosticoMultiprofissionais': diagnosticoMultiprofissionais.toMap(),
      'doencasClinicas': doencasClinicas.toMap(),
      'medicacoesModel': medicacoesModel.toMap(),
      'outrasInformacoesModel': outrasInformacoesModel.toMap(),
      'potencialidadeModel': potencialidadeModel.toMap(),
      'recursoIndividuaisModel': recursoIndividuaisModel.toMap(),
    };
  }
}
