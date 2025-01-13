import 'package:cloud_firestore/cloud_firestore.dart';

class ListaDificuldadePessoal {
  String? dificuldadePessoal;
  String? dificuldadeColetiva;
  String? dificuldadeEstruturais;
  Timestamp? dataCriacao;

  ListaDificuldadePessoal({
    this.dificuldadePessoal,
    this.dificuldadeColetiva,
    this.dificuldadeEstruturais,
    this.dataCriacao,
  });

  factory ListaDificuldadePessoal.fromMap(Map<String, dynamic> map) {
    return ListaDificuldadePessoal(
      dificuldadePessoal: map['dificuldadePessoal'],
      dificuldadeColetiva: map['dificuldadeColetiva'],
      dificuldadeEstruturais: map['dificuldadeEstruturais'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dificuldadePessoal': dificuldadePessoal,
      'dificuldadeColetiva': dificuldadeColetiva,
      'dificuldadeEstruturais': dificuldadeEstruturais,
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
