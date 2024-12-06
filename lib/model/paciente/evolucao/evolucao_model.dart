import 'package:cloud_firestore/cloud_firestore.dart';

class EvolucaoModel {
  String? comentario;
  String? nome;
  String? foto;
  Timestamp? dataCriancao;

  EvolucaoModel({
    this.nome,
    this.comentario,
    this.foto,
    this.dataCriancao,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'comentario': comentario,
      'foto': foto,
      'dataCriancao': dataCriancao,
    };
  }

  factory EvolucaoModel.fromMap(Map<String, dynamic> data) {
    return EvolucaoModel(
      nome: data['nome'],
      comentario: data['comentario'],
      foto: data['foto'],
      dataCriancao: data['dataCriancao'],
    );
  }
}