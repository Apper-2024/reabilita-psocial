import 'package:cloud_firestore/cloud_firestore.dart';

class DoencaClinicaModel {
  String? doencaClinica;
  Timestamp? dataCriacao;

  DoencaClinicaModel({this.doencaClinica, this.dataCriacao});

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
  List<DoencaClinicaModel>? doencasClinicas;

  ListaDoencaClinica({this.doencasClinicas});

  factory ListaDoencaClinica.fromMap(Map<String, dynamic> map) {
    return ListaDoencaClinica(
      doencasClinicas: map['doencasClinicas'] != null
          ? List<DoencaClinicaModel>.from(
              map['doencasClinicas'].map((item) => DoencaClinicaModel.fromMap(item)),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doencasClinicas': doencasClinicas?.map((item) => item.toMap()).toList(),
    };
  }
}
