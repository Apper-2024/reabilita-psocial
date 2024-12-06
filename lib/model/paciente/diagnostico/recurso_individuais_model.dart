import 'package:cloud_firestore/cloud_firestore.dart';

class RecursoIndividuaisModel {
  String? recursoIndividual;
  List<String>? habilidades;

  RecursoIndividuaisModel({this.recursoIndividual, this.habilidades});

  factory RecursoIndividuaisModel.fromMap(Map<String, dynamic> map) {
    return RecursoIndividuaisModel(
      recursoIndividual: map['recursoIndividual'],
      habilidades: map['habilidades'] != null ? List<String>.from(map['habilidades']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recursoIndividual': recursoIndividual,
      'habilidades': habilidades,
    };
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
}
