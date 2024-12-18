import 'package:cloud_firestore/cloud_firestore.dart';

class ListaDificuldadePessoal {
  String? dificuldadePessoal;
  Timestamp? dataCriacao;

  ListaDificuldadePessoal({this.dificuldadePessoal, this.dataCriacao});

  factory ListaDificuldadePessoal.fromMap(Map<String, dynamic> map) {
    return ListaDificuldadePessoal(
      dificuldadePessoal: map['dificuldadePessoal'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dificuldadePessoal': dificuldadePessoal,
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
