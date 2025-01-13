import 'package:cloud_firestore/cloud_firestore.dart';

class MetaList {
  String? meta;
  Timestamp? dataCriacao;
  String? tipo;

  MetaList({this.meta, this.dataCriacao, this.tipo});

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

  MetaModel({List<MetaList>? metas}) : metas = metas ?? [];

  factory MetaModel.fromMap(Map<String, dynamic> data) {
    return MetaModel(
      metas: data['metas'] != null
          ? List<MetaList>.from(
              data['metas'].map((item) => MetaList.fromMap(item)),
            )
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metas': metas.map((meta) => meta.toMap()).toList(),
    };
  }
}