import 'package:cloud_firestore/cloud_firestore.dart';

class EvolucaoModel {
  String comentario;
  String nome;
  String foto;
  Timestamp dataCriancao;

  EvolucaoModel({
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

  factory EvolucaoModel.fromMap(Map<String, dynamic> map) {
    return EvolucaoModel(
      nome: map['nome'],
      comentario: map['comentario'],
      foto: map['foto'],
      dataCriancao: map['dataCriancao'],
    );
  }
}
