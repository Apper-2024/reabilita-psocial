import 'package:reabilita_social/model/paciente/diagnostico/desejo_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_multiprofissional_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/dificuldade_pessoal_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/doencas_clinicas_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/medicacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/outras_informacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/potencialidade_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/problema_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/recurso_individuais_model.dart';

class DiagnosticoModal {
  DesejoModel? desejoModel;
  HistoriaCasoModel? historiaCasoModel;
  ListaDoencaClinica? doencasClinicasModel;
  ListaDeMedicacoes? medicacoesModel;
  ListaOutrasInformacoes? outrasInformacoesModel;
  PotencialidadeModel? potencialidadeModel;
  RecursoIndividuaisModel? recursoIndividuaisModel;
  DificuldadePessoalModal? dificuldadePessoalModel;
  ProblemaModel? problemaModel;

  DiagnosticoModal({
    this.desejoModel,
    this.historiaCasoModel,
    this.doencasClinicasModel,
    this.medicacoesModel,
    this.outrasInformacoesModel,
    this.potencialidadeModel,
    this.recursoIndividuaisModel,
    this.dificuldadePessoalModel,
    this.problemaModel,
  });

  factory DiagnosticoModal.fromMap(Map<String, dynamic> data) {
    return DiagnosticoModal(
      desejoModel: data['desejoModel'] != null ? DesejoModel.fromMap(data['desejoModel']) : null,
      historiaCasoModel:
          data['historiaCasoModel'] != null ? HistoriaCasoModel.fromMap(data['historiaCasoModel']) : null,
      doencasClinicasModel:
          data['doencasClinicasModel'] != null ? ListaDoencaClinica.fromMap(data['doencasClinicasModel']) : null,
      medicacoesModel: data['medicacoesModel'] != null ? ListaDeMedicacoes.fromMap(data['medicacoesModel']) : null,
      outrasInformacoesModel: data['outrasInformacoesModel'] != null
          ? ListaOutrasInformacoes.fromMap(data['outrasInformacoesModel'])
          : null,
      potencialidadeModel:
          data['potencialidadeModel'] != null ? PotencialidadeModel.fromMap(data['potencialidadeModel']) : null,
      recursoIndividuaisModel: data['recursoIndividuaisModel'] != null
          ? RecursoIndividuaisModel.fromMap(data['recursoIndividuaisModel'])
          : null,
      dificuldadePessoalModel: data['dificuldadePessoalModel'] != null
          ? DificuldadePessoalModal.fromMap(data['dificuldadePessoalModel'])
          : null,
      problemaModel: data['problemaModel'] != null ? ProblemaModel.fromMap(data['problemaModel']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'desejoModel': desejoModel?.toMap(),
      'historiaCasoModel': historiaCasoModel?.toMap(),
      'doencasClinicasModel': doencasClinicasModel?.toMap(),
      'medicacoesModel': medicacoesModel?.toMap(),
      'outrasInformacoesModel': outrasInformacoesModel?.toMap(),
      'potencialidadeModel': potencialidadeModel?.toMap(),
      'recursoIndividuaisModel': recursoIndividuaisModel?.toMap(),
      'dificuldadePessoalModel': dificuldadePessoalModel?.toMap(),
      'problemaModel': problemaModel?.toMap(),
    };
  }
}
