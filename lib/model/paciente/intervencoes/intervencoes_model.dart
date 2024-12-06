import 'package:cloud_firestore/cloud_firestore.dart';

class IntervencoesModel {
  List<ListIntervencoesModel> listIntervencoes;

  IntervencoesModel({ required this.listIntervencoes});

  factory IntervencoesModel.fromMap(Map<String, dynamic> map) {
    return IntervencoesModel(
      listIntervencoes: List<ListIntervencoesModel>.from(
        map['listIntervencoes'].map((item) => ListIntervencoesModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'listIntervencoes': listIntervencoes.map((item) => item.toMap()).toList(),
    };
  }
}

class ListIntervencoesModel {
  String problema;
  String intervencoes;
  Timestamp dataCriacao;
  String nomeResponsavel;
  String meta;
  String prazo;
  Timestamp data;

  ListIntervencoesModel({
    required this.problema,
    required this.intervencoes,
    required this.dataCriacao,
    required this.nomeResponsavel,
    required this.meta,
    required this.prazo,
    required this.data,
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
