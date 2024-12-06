import 'package:reabilita_social/model/paciente/diagnostico/desejo_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_multiprofissional_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/doencas_clinicas_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/medicacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/outras_informacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/potencialidade_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/recurso_individuais_model.dart';

class DiagnosticoModal {
  DesejoModel? desejoModel;
  HistoriaCasoModel? historiaCasoModel;
  DoencaClinicaModel? doencasClinicas;
  MedicacoesModel? medicacoesModel;
  OutrasInformacoesDiagnosticoModel? outrasInformacoesModel;
  PotencialidadeModel? potencialidadeModel;
  RecursoIndividuaisModel? recursoIndividuaisModel;

  DiagnosticoModal({
    this.desejoModel,
    this.historiaCasoModel,
    this.doencasClinicas,
    this.medicacoesModel,
    this.outrasInformacoesModel,
    this.potencialidadeModel,
    this.recursoIndividuaisModel,
  });

  factory DiagnosticoModal.fromMap(Map<String, dynamic> data) {
    return DiagnosticoModal(
      desejoModel: data['desejoModel'] != null ? DesejoModel.fromMap(data['desejoModel']) : null,
      historiaCasoModel: data['historiaCasoModel'] != null ? HistoriaCasoModel.fromMap(data['historiaCasoModel']) : null,
      doencasClinicas: data['doencasClinicas'] != null ? DoencaClinicaModel.fromMap(data['doencasClinicas']) : null,
      medicacoesModel: data['medicacoesModel'] != null ? MedicacoesModel.fromMap(data['medicacoesModel']) : null,
      outrasInformacoesModel: data['outrasInformacoesModel'] != null ? OutrasInformacoesDiagnosticoModel.fromMap(data['outrasInformacoesModel']) : null,
      potencialidadeModel: data['potencialidadeModel'] != null ? PotencialidadeModel.fromMap(data['potencialidadeModel']) : null,
      recursoIndividuaisModel: data['recursoIndividuaisModel'] != null ? RecursoIndividuaisModel.fromMap(data['recursoIndividuaisModel']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'desejoModel': desejoModel?.toMap(),
      'historiaCasoModel': historiaCasoModel?.toMap(),
      'doencasClinicas': doencasClinicas?.toMap(),
      'medicacoesModel': medicacoesModel?.toMap(),
      'outrasInformacoesModel': outrasInformacoesModel?.toMap(),
      'potencialidadeModel': potencialidadeModel?.toMap(),
      'recursoIndividuaisModel': recursoIndividuaisModel?.toMap(),
    };
  }
}