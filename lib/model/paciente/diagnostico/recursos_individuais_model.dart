class RecursosIndividuaisModel {
  String recursosIndividuais;
  List<HabilidadesModel> habilidades;

  RecursosIndividuaisModel({
    required this.recursosIndividuais,
    required this.habilidades,
  });

  Map<String, dynamic> toMap() {
    return {
      'recursosIndividuais': recursosIndividuais,
      'habilidades': habilidades.map((x) => x.toMap()).toList(),
    };
  }

  factory RecursosIndividuaisModel.fromMap(Map<String, dynamic> map) {
    return RecursosIndividuaisModel(
      recursosIndividuais: map['recursosIndividuais'],
      habilidades: List<HabilidadesModel>.from(map['habilidades']?.map((x) => HabilidadesModel.fromMap(x))),
    );
  }
}

class HabilidadesModel {
  List<String> habilidades;
  DateTime dataCriacao;

  HabilidadesModel({
    required this.habilidades,
    required this.dataCriacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'habilidades': habilidades,
      'dataCriacao': dataCriacao.toIso8601String(),
    };
  }

  factory HabilidadesModel.fromMap(Map<String, dynamic> map) {
    return HabilidadesModel(
      habilidades: List<String>.from(map['habilidades']),
      dataCriacao: DateTime.parse(map['dataCriacao']),
    );
  }
}