import 'package:cloud_firestore/cloud_firestore.dart';

class MedicacoesModel {
  String? medicacao;
  String? posologia;
  String? quantidade;
  String? frequencia;
  String? via;
  Timestamp? dataCriacao;

  MedicacoesModel({
    this.medicacao,
    this.posologia,
    this.quantidade,
    this.frequencia,
    this.via,
    this.dataCriacao,
  });

  factory MedicacoesModel.fromMap(Map<String, dynamic> map) {
    return MedicacoesModel(
      medicacao: map['medicacao'],
      posologia: map['posologia'],
      quantidade: map['quantidade'],
      frequencia: map['frequencia'],
      via: map['via'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medicacao': medicacao,
      'posologia': posologia,
      'quantidade': quantidade,
      'frequencia': frequencia,
      'via': via,
      'dataCriacao': dataCriacao,
    };
  }
}

class ListaDeMedicacoes {
  List<MedicacoesModel> medicacoes;

  ListaDeMedicacoes({required this.medicacoes});

  factory ListaDeMedicacoes.fromMap(Map<String, dynamic> map) {
    return ListaDeMedicacoes(
      medicacoes: List<MedicacoesModel>.from(
        map['medicacoes'].map((item) => MedicacoesModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medicacoes': medicacoes.map((item) => item.toMap()).toList(),
    };
  }
}
