import 'package:cloud_firestore/cloud_firestore.dart';

class Problema {
  String? problema;
  Timestamp? dataCriacao;

  Problema({this.problema, this.dataCriacao});

  factory Problema.fromMap(Map<String, dynamic> map) {
    return Problema(
      problema: map['problema'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'problema': problema,
      'dataCriacao': dataCriacao,
    };
  }

  void updateFromValue(String value) {
    problema = value;
  }
}

class ProblemaModel {
  List<Problema>? problema;

  ProblemaModel({this.problema});

  factory ProblemaModel.fromMap(Map<String, dynamic> map) {
    return ProblemaModel(
      problema: map['problema'] != null
          ? List<Problema>.from(map['problema'].map((item) => Problema.fromMap(item)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'problema': problema?.map((item) => item.toMap()).toList(),
    };
  }

  void updateFromList(List<String> values) {
    if (values.isNotEmpty) {
      if (problema != null) {
        for (int i = 0; i < values.length; i++) {
          if (i < problema!.length) {
            problema![i].updateFromValue(values[i]);
          } else if (values[i].isNotEmpty) {
            problema!.add(Problema(
              problema: values[i],
              dataCriacao: Timestamp.now(),
            ));
          }
        }
        // Remove problemas extras se a nova lista for menor
        if (problema!.length > values.length) {
          problema!.removeRange(values.length, problema!.length);
        }
      } else {
        problema = values
            .where((value) => value.isNotEmpty)
            .map((value) => Problema(
                  problema: value,
                  dataCriacao: Timestamp.now(),
                ))
            .toList();
      }
    }
  }
}