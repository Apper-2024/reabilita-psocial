import 'package:flutter/material.dart';
import 'package:reabilita_social/model/paciente/agenda/agenda_model.dart';
import 'package:reabilita_social/model/paciente/avaliacao/avaliacao_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/desejo_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_multiprofissional_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/doencas_clinicas_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/medicacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/outras_informacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/potencialidade_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/recurso_individuais_model.dart';
import 'package:reabilita_social/model/paciente/evolucao/evolucao_model.dart';
import 'package:reabilita_social/model/paciente/intervencoes/intervencoes_model.dart';
import 'package:reabilita_social/model/paciente/metas/meta_model.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';
import 'package:reabilita_social/model/paciente/pactuacoes/pactuacao_model.dart';

class PacienteProvider with ChangeNotifier {
  static final PacienteProvider _instance = PacienteProvider._internal();

  PacienteProvider._internal();

  static PacienteProvider get instance => _instance;

  PacienteModel? _paciente;

  PacienteModel? get paciente => _paciente;

  void setPaciente(PacienteModel u) {
    _paciente = u;
    notifyListeners();
  }

  void setHistoria(HistoriaCasoModel u) {
    _paciente?.diagnosticoModal?.historiaCasoModel = u;
    notifyListeners();
  }

  void setUpdateFotoHistoria(String u) {
    _paciente?.diagnosticoModal?.historiaCasoModel!.foto!.add(u);
    notifyListeners();
  }

  void setUpdateDiagnostico(DiagnosticoMultiprofissionaisModel u) {
    _paciente?.diagnosticoModal?.historiaCasoModel!.diagnosticos!.add(u);
    notifyListeners();
  }

  void setUpdateRecursoIndividual(RecursoIndividuaisModel u) {
    _paciente?.diagnosticoModal?.recursoIndividuaisModel = u;
    notifyListeners();
  }

  void setUpdateHabilidade(Habilidades u) {
    _paciente?.diagnosticoModal?.recursoIndividuaisModel!.habilidades!.add(u);
    notifyListeners();
  }

  void setUpdatePotencialidade(PotencialidadeModel u) {
    _paciente?.diagnosticoModal?.potencialidadeModel = u;
    notifyListeners();
  }

  void setUpdateDesejo(DesejoModel u) {
    _paciente?.diagnosticoModal?.desejoModel = u;
    notifyListeners();
  }

  void setUpdateMedicacoes(ListaDeMedicacoes u) {
    _paciente?.diagnosticoModal?.medicacoesModel = u;
    notifyListeners();
  }

  void setUpdateDoenca(ListaDoencaClinica u) {
    _paciente?.diagnosticoModal?.doencasClinicasModel = u;
    notifyListeners();
  }

  void setUpdateOutrasInformacoes(ListaOutrasInformacoes u) {
    _paciente?.diagnosticoModal?.outrasInformacoesModel = u;
    notifyListeners();
  }

  void setUpdateMeta(MetaModel u) {
    _paciente?.metasModel = u;
    notifyListeners();
  }

  void setUpdateIntervencao(IntervencoesModel u) {
    _paciente?.intervencoesModel = u;
    notifyListeners();
  }

  void setUpdatePactuacao(ListPactuacaoModel u) {
    _paciente?.pactuacoesModel = u;
    notifyListeners();
  }

  void setUpdateAgenda(AgendaModel u) {
    _paciente?.listaAgendaModel = u;
    notifyListeners();
  }

  void setUpdateAvaliacoes(AvaliacaoModel u) {
    _paciente?.avaliacoesModel = u;
    notifyListeners();
  }

  void setUpdateEvolucao(ListEvolucao u) {
    _paciente?.evolucoesModel?.evolucoesModel ??= [];

    bool exists = _paciente!.evolucoesModel!.evolucoesModel!.any((item) => item.dataCriancao == u.dataCriancao);
    if (!exists) {
      _paciente?.evolucoesModel?.evolucoesModel?.add(u);
      notifyListeners();
    }
  }
}
