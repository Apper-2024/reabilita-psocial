import 'package:cloud_firestore/cloud_firestore.dart';

class IntervencoesModel {
  String problema;
  List<ListIntervencoesModel> listIntervencoes;

  IntervencoesModel({required this.problema, required this.listIntervencoes});

  factory IntervencoesModel.fromMap(Map<String, dynamic> map) {
    return IntervencoesModel(
      problema: map['problema'],
      listIntervencoes: List<ListIntervencoesModel>.from(
        map['listIntervencoes'].map((item) => ListIntervencoesModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'problema': problema,
      'listIntervencoes': listIntervencoes.map((item) => item.toMap()).toList(),
    };
  }
}

class ListIntervencoesModel {
  String intervencoes;
  Timestamp dataCriacao;
  String nomeResponsavel;
  String meta;
  String prazo;
  Timestamp data;

  ListIntervencoesModel({
    required this.intervencoes,
    required this.dataCriacao,
    required this.nomeResponsavel,
    required this.meta,
    required this.prazo,
    required this.data,
  });

  factory ListIntervencoesModel.fromMap(Map<String, dynamic> map) {
    return ListIntervencoesModel(
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
      'intervencoes': intervencoes,
      'dataCriacao': dataCriacao,
      'nomeResponsavel': nomeResponsavel,
      'meta': meta,
      'prazo': prazo,
      'data': data,
    };
  }
}