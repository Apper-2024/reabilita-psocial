import 'package:cloud_firestore/cloud_firestore.dart';

class Potencialidade {
  String? potencialidade;
  Timestamp? dataCriacao;

  Potencialidade({this.potencialidade, this.dataCriacao});

  factory Potencialidade.fromMap(Map<String, dynamic> map) {
    return Potencialidade(
      potencialidade: map['potencialidade'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'potencialidade': potencialidade,
      'dataCriacao': dataCriacao,
    };
  }
    void updateFromValue(String value) {
    potencialidade = value;
  }

  
}

class PotencialidadeModel {
  List<Potencialidade>? potencialidades;

  PotencialidadeModel({this.potencialidades});

  factory PotencialidadeModel.fromMap(Map<String, dynamic> map) {
    return PotencialidadeModel(
      potencialidades: map['potencialidades'] != null
          ? List<Potencialidade>.from(map['potencialidades'].map((item) => Potencialidade.fromMap(item)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'potencialidades': potencialidades?.map((potencialidade) => potencialidade.toMap()).toList(),
    };
  }

  
  void updateFromList(List<String> values) {
    if (values.isNotEmpty) {
      if (potencialidades != null) {
        for (int i = 0; i < values.length; i++) {
          if (i < potencialidades!.length) {
            potencialidades![i].updateFromValue(values[i]);
          } else if (values[i].isNotEmpty) {
            potencialidades!.add(Potencialidade(potencialidade: values[i], dataCriacao: Timestamp.now()));
          }
        }
        // Remove potencialidades extras se a nova lista for menor
        if (potencialidades!.length > values.length) {
          potencialidades!.removeRange(values.length, potencialidades!.length);
        }
      } else {
        potencialidades = values.where((value) => value.isNotEmpty).map((value) => Potencialidade(potencialidade: value, dataCriacao: Timestamp.now())).toList();
      }
    }
  }
}