import 'package:cloud_firestore/cloud_firestore.dart';

class AvaliacaoModel {
  String intervencao;
  String responsavel;
  String avaliacao;
  String observacao;
  String foto;
  Timestamp data;

  AvaliacaoModel({
    required this.intervencao,
    required this.responsavel,
    required this.avaliacao,
    required this.observacao,
    required this.foto,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'intervencao': intervencao,
      'responsavel': responsavel,
      'avaliacao': avaliacao,
      'observacao': observacao,
      'foto': foto,
      'data': data,
    };
  }

  factory AvaliacaoModel.fromMap(Map<String, dynamic> map) {
    return AvaliacaoModel(
      intervencao: map['intervencao'],
      responsavel: map['responsavel'],
      avaliacao: map['avaliacao'],
      observacao: map['observacao'],
      foto: map['foto'],
      data: map['data'],
    );
  }
}