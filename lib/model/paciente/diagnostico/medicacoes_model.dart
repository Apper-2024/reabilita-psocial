class MedicacoesModel {
  String? medicacao;
  String? quantidade;
  String? via;
  String? frequencia;

  MedicacoesModel({
    this.medicacao,
    this.quantidade,
    this.via,
    this.frequencia,
  });

  factory MedicacoesModel.fromMap(Map<String, dynamic> map) {
    return MedicacoesModel(
      medicacao: map['medicacao'],
      quantidade: map['quantidade'],
      via: map['via'],
      frequencia: map['frequencia'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medicacao': medicacao,
      'quantidade': quantidade,
      'via': via,
      'frequencia': frequencia,
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