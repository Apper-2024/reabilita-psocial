import 'package:cloud_firestore/cloud_firestore.dart';

class RecursoIndividuaisModel {
  String? recursoIndividual;
  List<Habilidades>? habilidades;

  RecursoIndividuaisModel({this.recursoIndividual, this.habilidades});

  factory RecursoIndividuaisModel.fromMap(Map<String, dynamic> map) {
    return RecursoIndividuaisModel(
      recursoIndividual: map['recursoIndividual'],
      habilidades: map['habilidades'] != null ? List<Habilidades>.from(map['habilidades'].map((item) => Habilidades.fromMap(item))) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recursoIndividual': recursoIndividual,
      'habilidades': habilidades?.map((habilidade) => habilidade.toMap()).toList(), // Converte cada item da lista para um mapa
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