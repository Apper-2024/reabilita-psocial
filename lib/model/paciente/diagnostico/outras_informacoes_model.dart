import 'package:cloud_firestore/cloud_firestore.dart';

class OutrasInformacoesDiagnosticoModel {
  String? outrasInformacoes;
  Timestamp? dataCriacao;

  OutrasInformacoesDiagnosticoModel({this.outrasInformacoes, this.dataCriacao});

  factory OutrasInformacoesDiagnosticoModel.fromMap(Map<String, dynamic> map) {
    return OutrasInformacoesDiagnosticoModel(
      outrasInformacoes: map['outrasInformacoes'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'outrasInformacoes': outrasInformacoes,
      'dataCriacao': dataCriacao,
    };
  }
}

class ListaOutrasInformacoes {
  List<OutrasInformacoesDiagnosticoModel>? listaOutrasInformacoes;

  ListaOutrasInformacoes({this.listaOutrasInformacoes});

  factory ListaOutrasInformacoes.fromMap(Map<String, dynamic> map) {
    return ListaOutrasInformacoes(
      listaOutrasInformacoes: map['listaOutrasInformacoes'] != null
          ? List<OutrasInformacoesDiagnosticoModel>.from(
              map['listaOutrasInformacoes'].map((x) => OutrasInformacoesDiagnosticoModel.fromMap(x)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'listaOutrasInformacoes':
          listaOutrasInformacoes != null ? List<dynamic>.from(listaOutrasInformacoes!.map((x) => x.toMap())) : null,
    };
  }
}
