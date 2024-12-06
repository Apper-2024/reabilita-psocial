import 'package:cloud_firestore/cloud_firestore.dart';

class MetaList {
  String meta;
  Timestamp dataCriacao;
  String tipo;

  MetaList({required this.meta, required this.dataCriacao, required this.tipo});

  factory MetaList.fromMap(Map<String, dynamic> map) {
    return MetaList(
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

class MetaModel {
  List<MetaList> metas;

  MetaModel({required this.metas});

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      metas: List<MetaList>.from(
        map['metas']?.map((item) => MetaList.fromMap(item)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metas': metas.map((meta) => meta.toMap()).toList(),
    };
  }
}