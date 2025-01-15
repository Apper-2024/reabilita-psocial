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

  void updateFromValue(String value) {
    doencaClinica = value;
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

  void updateFromList(List<String> values) {
    if (values.isNotEmpty) {
      if (doencasClinicas != null) {
        for (int i = 0; i < values.length; i++) {
          if (i < doencasClinicas!.length) {
            doencasClinicas![i].updateFromValue(values[i]);
          } else if (values[i].isNotEmpty) {
            doencasClinicas!.add(DoencaClinicaModel(
              doencaClinica: values[i],
              dataCriacao: Timestamp.now(),
            ));
          }
        }
        // Remove doenças extras se a nova lista for menor
        if (doencasClinicas!.length > values.length) {
          doencasClinicas!.removeRange(values.length, doencasClinicas!.length);
        }
      } else {
        doencasClinicas = values
            .where((value) => value.isNotEmpty)
            .map((value) => DoencaClinicaModel(
                  doencaClinica: value,
                  dataCriacao: Timestamp.now(),
                ))
            .toList();
      }
    }
  }
}