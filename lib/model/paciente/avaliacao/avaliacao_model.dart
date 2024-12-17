import 'package:cloud_firestore/cloud_firestore.dart';

class AvaliacaoModel {
  List<ListAvaliacao>? avaliacoesModel;

  AvaliacaoModel({
    this.avaliacoesModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'avaliacoesModel': avaliacoesModel?.map((e) => e.toMap()).toList(),
    };
  }

  factory AvaliacaoModel.fromMap(Map<String, dynamic> map) {
    return AvaliacaoModel(
      avaliacoesModel: map['avaliacoesModel'] != null
          ? List<ListAvaliacao>.from(map['avaliacoesModel'].map((x) => ListAvaliacao.fromMap(x)))
          : null,
    );
  }
}

class ListAvaliacao {
  String? intervencao;
  String? responsavel;
  String? avaliacao;
  String? observacao;
  String? foto;
  Timestamp? dataCriacao;

  ListAvaliacao({
    this.intervencao,
    this.responsavel,
    this.avaliacao,
    this.observacao,
    this.foto,
    this.dataCriacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'intervencao': intervencao,
      'responsavel': responsavel,
      'avaliacao': avaliacao,
      'observacao': observacao,
      'foto': foto,
      'dataCriacao': dataCriacao,
    };
  }

  factory ListAvaliacao.fromMap(Map<String, dynamic> map) {
    return ListAvaliacao(
      intervencao: map['intervencao'],
      responsavel: map['responsavel'],
      avaliacao: map['avaliacao'],
      observacao: map['observacao'],
      foto: map['foto'],
      dataCriacao: map['dataCriacao'],
    );
  }
}
