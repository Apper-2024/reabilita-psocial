import 'package:cloud_firestore/cloud_firestore.dart';

class PactuacaoModel {
  String paciente;
  String responsavelPactuacao;
  String prazo;
  String familia;
  String responsavel;
  String foto;
  Timestamp data;

  PactuacaoModel({
    required this.paciente,
    required this.responsavelPactuacao,
    required this.prazo,
    required this.familia,
    required this.responsavel,
    required this.foto,
    required this.data,
  });

  factory PactuacaoModel.fromMap(Map<String, dynamic> map) {
    return PactuacaoModel(
      paciente: map['paciente'],
      responsavelPactuacao: map['responsavelPactuacao'],
      prazo: map['prazo'],
      familia: map['familia'],
      responsavel: map['responsavel'],
      foto: map['foto'],
      data: map['data'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paciente': paciente,
      'responsavelPactuacao': responsavelPactuacao,
      'prazo': prazo,
      'familia': familia,
      'responsavel': responsavel,
      'foto': foto,
      'data': data,
    };
  }
}
