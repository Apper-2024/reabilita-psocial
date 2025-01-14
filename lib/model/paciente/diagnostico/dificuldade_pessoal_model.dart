import 'package:cloud_firestore/cloud_firestore.dart';

class ListaDificuldadePessoal {
  String? dificuldade;
  String? tipoDificuldade;
  Timestamp? dataCriacao;

  ListaDificuldadePessoal({
    this.dificuldade,
    this.tipoDificuldade,
    this.dataCriacao,
  });

  factory ListaDificuldadePessoal.fromMap(Map<String, dynamic> map) {
    return ListaDificuldadePessoal(
      dificuldade: map['dificuldade'],
      tipoDificuldade: map['tipoDificuldade'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dificuldade': dificuldade,
      'tipoDificuldade': tipoDificuldade,
      'dataCriacao': dataCriacao,
    };
  }
}

class DificuldadePessoalModal {
  List<ListaDificuldadePessoal>? dificuldadePessoal;

  DificuldadePessoalModal({this.dificuldadePessoal});

  factory DificuldadePessoalModal.fromMap(Map<String, dynamic> map) {
    return DificuldadePessoalModal(
      dificuldadePessoal: map['dificuldadePessoal'] != null
          ? List<ListaDificuldadePessoal>.from(
              map['dificuldadePessoal'].map((item) => ListaDificuldadePessoal.fromMap(item)),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dificuldadePessoal': dificuldadePessoal?.map((item) => item.toMap()).toList(),
    };
  }
}
