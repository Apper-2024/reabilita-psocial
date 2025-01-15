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

  void updateFromValue(String value) {
    outrasInformacoes = value;
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
      'listaOutrasInformacoes': listaOutrasInformacoes != null
          ? List<dynamic>.from(listaOutrasInformacoes!.map((x) => x.toMap()))
          : null,
    };
  }

  void updateFromList(List<String> values) {
    if (values.isNotEmpty) {
      if (listaOutrasInformacoes != null) {
        for (int i = 0; i < values.length; i++) {
          if (i < listaOutrasInformacoes!.length) {
            listaOutrasInformacoes![i].updateFromValue(values[i]);
          } else if (values[i].isNotEmpty) {
            listaOutrasInformacoes!.add(OutrasInformacoesDiagnosticoModel(
              outrasInformacoes: values[i],
              dataCriacao: Timestamp.now(),
            ));
          }
        }
        // Remove informações extras se a nova lista for menor
        if (listaOutrasInformacoes!.length > values.length) {
          listaOutrasInformacoes!.removeRange(values.length, listaOutrasInformacoes!.length);
        }
      } else {
        listaOutrasInformacoes = values
            .where((value) => value.isNotEmpty)
            .map((value) => OutrasInformacoesDiagnosticoModel(
                  outrasInformacoes: value,
                  dataCriacao: Timestamp.now(),
                ))
            .toList();
      }
    }
  }
}