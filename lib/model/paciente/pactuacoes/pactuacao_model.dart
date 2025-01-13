import 'package:cloud_firestore/cloud_firestore.dart';

class PactuacaoModel {
  String? prazo;
  String? responsavel;
  String? intervencao;
  String? tipo;
  String? foto;
  Timestamp? dataCriacao;

  PactuacaoModel({
    this.prazo,
    this.responsavel,
    this.intervencao,
    this.tipo,
    this.foto,
    this.dataCriacao,
  });

  factory PactuacaoModel.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return PactuacaoModel();
    }
    return PactuacaoModel(
      prazo: data['prazo'],
      responsavel: data['responsavel'],
      intervencao: data['intervencao'],
      tipo: data['tipo'],
      foto: data['foto'],
      dataCriacao: data['dataCriacao'],
    );
  }

  Map<String, dynamic>? toMap() {
    if (prazo == null &&
        responsavel == null &&
        intervencao == null &&
        tipo == null &&
        foto == null &&
        dataCriacao == null) {
      return null;
    }
    return {
      'prazo': prazo,
      'responsavel': responsavel,
      'intervencao': intervencao,
      'tipo': tipo,
      'foto': foto,
      'dataCriacao': dataCriacao,
    };
  }
}

class ListPactuacaoModel {
  List<PactuacaoModel>? pactuacoesModel;

  ListPactuacaoModel({this.pactuacoesModel});

  Map<String, dynamic>? toMap() {
    if (pactuacoesModel == null) {
      return null;
    }
    return {
      'pactuacoesModel': pactuacoesModel?.map((pactuacao) => pactuacao.toMap()).toList(),
    };
  }

  factory ListPactuacaoModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return ListPactuacaoModel();
    }
    return ListPactuacaoModel(
      pactuacoesModel: (map['pactuacoesModel'] as List<dynamic>?)
          ?.map((item) => PactuacaoModel.fromMap(item as Map<String, dynamic>?))
          .toList(),
    );
  }
}
