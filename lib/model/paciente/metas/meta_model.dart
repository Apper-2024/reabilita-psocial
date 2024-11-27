import 'package:cloud_firestore/cloud_firestore.dart';

class MetaModel {
  String meta;
  Timestamp dataCriacao;
  String tipo;

  MetaModel({required this.meta, required this.dataCriacao, required this.tipo});

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      meta: map['meta'],
      dataCriacao: map['dataCriacao'],
      tipo: map['tipo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'meta': meta,
      'dataCriacao': dataCriacao,
      'tipo': tipo,
    };
  }
}
