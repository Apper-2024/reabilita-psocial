import 'package:cloud_firestore/cloud_firestore.dart';

class PactuacaoModel {
  String? paciente;
  String? responsavelPactuacao;
  String? prazo;
  String? familia;
  String? responsavel;
  String? foto;
  Timestamp? data;

  PactuacaoModel({
    this.paciente,
    this.responsavelPactuacao,
    this.prazo,
    this.familia,
    this.responsavel,
    this.foto,
    this.data,
  });

  factory PactuacaoModel.fromMap(Map<String, dynamic> data) {
    return PactuacaoModel(
      paciente: data['paciente'],
      responsavelPactuacao: data['responsavelPactuacao'],
      prazo: data['prazo'],
      familia: data['familia'],
      responsavel: data['responsavel'],
      foto: data['foto'],
      data: data['data'],
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