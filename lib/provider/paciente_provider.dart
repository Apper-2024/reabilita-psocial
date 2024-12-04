import 'package:flutter/material.dart';
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
}
