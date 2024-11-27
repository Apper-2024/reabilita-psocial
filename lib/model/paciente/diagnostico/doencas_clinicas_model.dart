import 'package:cloud_firestore/cloud_firestore.dart';

class DoencaClinicaModel {
  String doencaClinica;
  Timestamp dataCriacao;

  DoencaClinicaModel({required this.doencaClinica, required this.dataCriacao});

  factory DoencaClinicaModel.fromMap(Map<String, dynamic> map) {
    return DoencaClinicaModel(
      doencaClinica: map['doencaClinica'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doencaClinica': doencaClinica,
      'dataCriacao': dataCriacao,
    };
  }
}

class ListaDoencaClinica {
  List<DoencaClinicaModel> doencasClinicas;

  ListaDoencaClinica({required this.doencasClinicas});

  factory ListaDoencaClinica.fromMap(Map<String, dynamic> map) {
    return ListaDoencaClinica(
      doencasClinicas: List<DoencaClinicaModel>.from(
        map['doencasClinicas'].map((item) => DoencaClinicaModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doencasClinicas': doencasClinicas.map((item) => item.toMap()).toList(),
    };
  }
}
