import 'package:cloud_firestore/cloud_firestore.dart';

class IntervencoesModel {
  List<ListIntervencoesModel> intervencoesModel;

  IntervencoesModel({List<ListIntervencoesModel>? intervencoesModel})
      : intervencoesModel = intervencoesModel ?? [];

  factory IntervencoesModel.fromMap(Map<String, dynamic> data) {
    return IntervencoesModel(
      intervencoesModel: data['intervencoesModel'] != null
          ? List<ListIntervencoesModel>.from(
              data['intervencoesModel'].map((item) => ListIntervencoesModel.fromMap(item)),
            )
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'intervencoesModel': intervencoesModel.map((item) => item.toMap()).toList(),
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

  ListIntervencoesModel({
    this.problema,
    this.intervencoes,
    this.dataCriacao,
    this.nomeResponsavel,
    this.meta,
    this.prazo,
  });

  factory ListIntervencoesModel.fromMap(Map<String, dynamic> map) {
    return ListIntervencoesModel(
      problema: map['problema'],
      intervencoes: map['intervencoes'],
      dataCriacao: map['dataCriacao'],
      nomeResponsavel: map['nomeResponsavel'],
      meta: map['meta'],
      prazo: map['prazo'],
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
    };
  }
}