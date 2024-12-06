import 'package:cloud_firestore/cloud_firestore.dart';

class IntervencoesModel {
  List<ListIntervencoesModel>? listIntervencoes;

  IntervencoesModel({this.listIntervencoes});

  factory IntervencoesModel.fromMap(Map<String, dynamic> data) {
    return IntervencoesModel(
      listIntervencoes: data['listIntervencoes'] != null
          ? List<ListIntervencoesModel>.from(
              data['listIntervencoes'].map((item) => ListIntervencoesModel.fromMap(item)),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'listIntervencoes': listIntervencoes?.map((item) => item.toMap()).toList(),
    };
  }
}

class ListIntervencoesModel {
  String? problema;
  String? intervencoes;
  Timestamp? dataCriacao;
  String? nomeResponsavel;
  String? meta;
  String? prazo;
  Timestamp? data;

  ListIntervencoesModel({
    this.problema,
    this.intervencoes,
    this.dataCriacao,
    this.nomeResponsavel,
    this.meta,
    this.prazo,
    this.data,
  });

  factory ListIntervencoesModel.fromMap(Map<String, dynamic> map) {
    return ListIntervencoesModel(
      problema: map['problema'],
      intervencoes: map['intervencoes'],
      dataCriacao: map['dataCriacao'],
      nomeResponsavel: map['nomeResponsavel'],
      meta: map['meta'],
      prazo: map['prazo'],
      data: map['data'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'problema': problema,
      'intervencoes': intervencoes,
      'dataCriacao': dataCriacao,
      'nomeResponsavel': nomeResponsavel,
      'meta': meta,
      'prazo': prazo,
      'data': data,
    };
  }
}