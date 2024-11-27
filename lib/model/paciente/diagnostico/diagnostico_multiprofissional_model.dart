import 'package:cloud_firestore/cloud_firestore.dart';

class DiagnosticoMultiprofissionaisModel {
  List<String> diagnosticos;
  Timestamp dataCriacao;
  String nomeResponsavel;
  String profissaoResponsavel;
  String cpf;

  DiagnosticoMultiprofissionaisModel({
    required this.diagnosticos,
    required this.dataCriacao,
    required this.nomeResponsavel,
    required this.profissaoResponsavel,
    required this.cpf,
  });

  factory DiagnosticoMultiprofissionaisModel.fromMap(Map<String, dynamic> map) {
    return DiagnosticoMultiprofissionaisModel(
      diagnosticos: List<String>.from(map['diagnosticos']),
      dataCriacao: map['dataCriacao'],
      nomeResponsavel: map['nomeResponsavel'],
      profissaoResponsavel: map['profissaoResponsavel'],
      cpf: map['cpf'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'diagnosticos': diagnosticos,
      'dataCriacao': dataCriacao
      ,
      'nomeResponsavel': nomeResponsavel,
      'profissaoResponsavel': profissaoResponsavel,
      'cpf': cpf,
    };
  }
}

class HistoriaCasoModel {
  String historia;
  List<DiagnosticoMultiprofissionaisModel> diagnosticos;
  List<String> foto;

  HistoriaCasoModel({
    required this.historia,
    required this.diagnosticos,
    required this.foto,
  });

  factory HistoriaCasoModel.fromMap(Map<String, dynamic> map) {
    return HistoriaCasoModel(
      historia: map['historia'],
      diagnosticos: List<DiagnosticoMultiprofissionaisModel>.from(
        map['diagnosticos'].map((item) => DiagnosticoMultiprofissionaisModel.fromMap(item)),
      ),
      foto: List<String>.from(map['foto']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'historia': historia,
      'diagnosticos': diagnosticos.map((item) => item.toMap()).toList(),
      'foto': foto,
    };
  }
}