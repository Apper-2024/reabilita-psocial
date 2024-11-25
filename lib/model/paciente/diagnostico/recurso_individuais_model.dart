class RecursoIndividuaisModel {
  String recursoIndividual;
  List<String> habilidades;

  RecursoIndividuaisModel({required this.recursoIndividual, required this.habilidades});

  factory RecursoIndividuaisModel.fromMap(Map<String, dynamic> map) {
    return RecursoIndividuaisModel(
      recursoIndividual: map['recursoIndividual'],
      habilidades: List<String>.from(map['habilidades']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recursoIndividual': recursoIndividual,
      'habilidades': habilidades,
    };
  }
}

class Habilidades {
  String habilidades;
  DateTime dataCriacao;

  Habilidades({required this.habilidades, required this.dataCriacao});

  factory Habilidades.fromMap(Map<String, dynamic> map) {
    return Habilidades(
      habilidades: map['habilidades'],
      dataCriacao: DateTime.parse(map['dataCriacao']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'habilidades': habilidades,
      'dataCriacao': dataCriacao.toIso8601String(),
    };
  }
}