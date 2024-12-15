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
}