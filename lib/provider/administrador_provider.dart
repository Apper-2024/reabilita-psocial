import 'package:flutter/material.dart';
import 'package:reabilita_social/model/administrador/administrador_model.dart';

class AdministradorProvider with ChangeNotifier {
  static final AdministradorProvider _instance = AdministradorProvider._internal();

  AdministradorProvider._internal();

  static AdministradorProvider get instance => _instance;

  AdministradorModel? _administrador;

  AdministradorModel? get usuario => _administrador;

  void setAdministrador(AdministradorModel u) {
    _administrador = u;
    notifyListeners();
  }


}
