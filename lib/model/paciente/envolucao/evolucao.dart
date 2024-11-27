import 'package:cloud_firestore/cloud_firestore.dart';

class Evolucao {
  String comentario;
  String nome;
  String foto;
  Timestamp dataCriancao;

  Evolucao({
    required this.nome,
    required this.comentario,
    required this.foto,
    required this.dataCriancao,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'comentario': comentario,
      'foto': foto,
      'dataCriancao': dataCriancao,
    };
  }

  factory Evolucao.fromMap(Map<String, dynamic> map) {
    return Evolucao(
      nome: map['nome'],
      comentario: map['comentario'],
      foto: map['foto'],
      dataCriancao: map['dataCriancao'],
    );
  }
}
