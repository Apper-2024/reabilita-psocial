import 'package:cloud_firestore/cloud_firestore.dart';


class DiagnosticoMultiprofissionaisModel {
  String? diagnosticos;
  Timestamp? dataCriacao;
  String? nomeResponsavel;
  String? profissaoResponsavel;
  String? cpf;

  DiagnosticoMultiprofissionaisModel({
    this.diagnosticos,
    this.dataCriacao,
    this.nomeResponsavel,
    this.profissaoResponsavel,
    this.cpf,
  });

  factory DiagnosticoMultiprofissionaisModel.fromMap(Map<String, dynamic> map) {
    return DiagnosticoMultiprofissionaisModel(
      diagnosticos: map['diagnosticos'],
      dataCriacao: map['dataCriacao'],
      nomeResponsavel: map['nomeResponsavel'],
      profissaoResponsavel: map['profissaoResponsavel'],
      cpf: map['cpf'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'diagnosticos': diagnosticos,
      'dataCriacao': dataCriacao,
      'nomeResponsavel': nomeResponsavel,
      'profissaoResponsavel': profissaoResponsavel,
      'cpf': cpf,
    };
  }
}
class HistoriaCasoModel {
  String? historia;
  List<DiagnosticoMultiprofissionaisModel>? diagnosticos;
  List<String>? foto;
  Timestamp? dataCriacao;

  HistoriaCasoModel({
    this.historia,
    this.diagnosticos,
    this.foto,
    this.dataCriacao,
  });

  factory HistoriaCasoModel.fromMap(Map<String, dynamic> map) {
    return HistoriaCasoModel(
      historia: map['historia'],
      diagnosticos: map['diagnosticos'] != null
          ? List<DiagnosticoMultiprofissionaisModel>.from(
              map['diagnosticos'].map((item) => DiagnosticoMultiprofissionaisModel.fromMap(item)),
            )
          : [],
      foto: map['foto'] != null ? List<String>.from(map['foto']) : [],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'historia': historia,
      'diagnosticos': diagnosticos?.map((item) => item.toMap()).toList(),
      'foto': foto,
      'dataCriacao': dataCriacao,
    };
  }
}