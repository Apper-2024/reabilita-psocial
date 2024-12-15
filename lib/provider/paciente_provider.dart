import 'package:flutter/material.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_multiprofissional_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/potencialidade_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/recurso_individuais_model.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';

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
}
