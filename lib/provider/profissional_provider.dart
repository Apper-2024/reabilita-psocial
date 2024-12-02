import 'package:flutter/material.dart';
import 'package:reabilita_social/model/profissional/profissional_model.dart';

class ProfissionalProvider with ChangeNotifier {
  static final ProfissionalProvider _instance = ProfissionalProvider._internal();

  ProfissionalProvider._internal();

  static ProfissionalProvider get instance => _instance;

  ProfissionalModel? _profissional;

  ProfissionalModel? get profissional => _profissional;

  void setProfissional(ProfissionalModel u) {
    _profissional = u;
    notifyListeners();
  }


}
