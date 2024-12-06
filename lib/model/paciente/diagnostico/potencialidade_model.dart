class PotencialidadeModel {
  List<String>? potencialidade;

  PotencialidadeModel({this.potencialidade});

  factory PotencialidadeModel.fromMap(Map<String, dynamic> map) {
    return PotencialidadeModel(
      potencialidade: map['potencialidade'] != null
          ? List<String>.from(map['potencialidade'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'potencialidade': potencialidade,
    };
  }
}