import 'package:cloud_firestore/cloud_firestore.dart';

class PactuacaoModel {
  String? paciente;
  String? responsavelPactuacao;
  String? prazo;
  String? familia;
  String? responsavel;
  String? foto;
  Timestamp? dataCriacao;

  PactuacaoModel({
    this.paciente,
    this.responsavelPactuacao,
    this.prazo,
    this.familia,
    this.responsavel,
    this.foto,
    this.dataCriacao,
  });

  factory PactuacaoModel.fromMap(Map<String, dynamic> data) {
    return PactuacaoModel(
      paciente: data['paciente'],
      responsavelPactuacao: data['responsavelPactuacao'],
      prazo: data['prazo'],
      familia: data['familia'],
      responsavel: data['responsavel'],
      foto: data['foto'],
      dataCriacao: data['dataCriacao'],
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
      'dataCriacao': dataCriacao,
    };
  }
}

class ListPactuacaoModel {
  List<PactuacaoModel>? pactuacoesModel;

  ListPactuacaoModel({this.pactuacoesModel});

  Map<String, dynamic> toMap() {
    return {
      'pactuacoesModel': pactuacoesModel?.map((pactuacao) => pactuacao.toMap()).toList(),
    };
  }

  factory ListPactuacaoModel.fromMap(Map<String, dynamic> map) {
    return ListPactuacaoModel(
      pactuacoesModel: List<PactuacaoModel>.from(
        map['pactuacoesModel']?.map((item) => PactuacaoModel.fromMap(item)) ?? [],
      ),
    );
  }
}
