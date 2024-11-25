class PotencialidadeModel {
  List<String> potencialidade;

  PotencialidadeModel({required this.potencialidade});

  factory PotencialidadeModel.fromMap(Map<String, dynamic> map) {
    return PotencialidadeModel(
      potencialidade: List<String>.from(map['potencialidade']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'potencialidade': potencialidade,
    };
  }
}