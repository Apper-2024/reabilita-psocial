import 'package:cloud_firestore/cloud_firestore.dart';

class EvolucaoModel {
  List<ListEvolucao>? evolucoesModel;

  EvolucaoModel({this.evolucoesModel});

  Map<String, dynamic> toMap() {
    return {
      'evolucoesModel': evolucoesModel?.map((e) => e.toMap()).toList(),
    };
  }

  factory EvolucaoModel.fromMap(Map<String, dynamic> data) {
    return EvolucaoModel(
      evolucoesModel: data['evolucoesModel'] != null
          ? List<ListEvolucao>.from(
              data['evolucoesModel'].map((item) => ListEvolucao.fromMap(item)))
          : null,
    );
  }
}

class ListEvolucao {
  String? comentario;
  String? nome;
  // String? foto;
  Timestamp? dataCriancao;

  ListEvolucao({
    this.nome,
    this.comentario,
    // this.foto,
    this.dataCriancao,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'comentario': comentario,
      // 'foto': foto,
      'dataCriancao': dataCriancao,
    };
  }

  factory ListEvolucao.fromMap(Map<String, dynamic> data) {
    return ListEvolucao(
      nome: data['nome'],
      comentario: data['comentario'],
      // foto: data['foto'],
      dataCriancao: data['dataCriancao'],
    );
  }
}