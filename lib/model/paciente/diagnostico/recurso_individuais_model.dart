import 'package:cloud_firestore/cloud_firestore.dart';

class RecursoIndividuaisModel {
  String? recursoIndividual;
  List<Habilidades>? habilidades;

  RecursoIndividuaisModel({this.recursoIndividual, this.habilidades});

  factory RecursoIndividuaisModel.fromMap(Map<String, dynamic> map) {
    return RecursoIndividuaisModel(
      recursoIndividual: map['recursoIndividual'],
      habilidades: map['habilidades'] != null
          ? List<Habilidades>.from(map['habilidades'].map((item) => Habilidades.fromMap(item)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recursoIndividual': recursoIndividual,
      'habilidades':
          habilidades?.map((habilidade) => habilidade.toMap()).toList(), // Converte cada item da lista para um mapa
    };
  }

  void updateFromList(List<String> values) {
    if (values.isNotEmpty) {
      recursoIndividual = values[0];
      if (habilidades != null) {
        for (int i = 1; i < values.length; i++) {
          if (i - 1 < habilidades!.length) {
            habilidades![i - 1].updateFromValue(values[i]);
          } else if (values[i].isNotEmpty) {
            habilidades!.add(Habilidades(habilidades: values[i], dataCriacao: Timestamp.now()));
          }
        }
        // Remove habilidades extras se a nova lista for menor
        if (habilidades!.length > values.length - 1) {
          habilidades!.removeRange(values.length - 1, habilidades!.length);
        }
      } else {
        habilidades = values
            .sublist(1)
            .where((value) => value.isNotEmpty)
            .map((value) => Habilidades(habilidades: value, dataCriacao: Timestamp.now()))
            .toList();
      }
    }
  }
}

class Habilidades {
  String? habilidades;
  Timestamp? dataCriacao;

  Habilidades({this.habilidades, this.dataCriacao});

  factory Habilidades.fromMap(Map<String, dynamic> map) {
    return Habilidades(
      habilidades: map['habilidades'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'habilidades': habilidades,
      'dataCriacao': dataCriacao,
    };
  }

  void updateFromValue(String value) {
    habilidades = value;
  }
}
