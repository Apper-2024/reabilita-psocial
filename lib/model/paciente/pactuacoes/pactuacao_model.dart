class PactuacaoModel {
  String paciente;
  String responsavelPactuacao;
  String prazo;
  String familia;
  String responsavel;
  String foto;
  DateTime data;

  PactuacaoModel({
    required this.paciente,
    required this.responsavelPactuacao,
    required this.prazo,
    required this.familia,
    required this.responsavel,
    required this.foto,
    required this.data,
  });

  factory PactuacaoModel.fromMap(Map<String, dynamic> map) {
    return PactuacaoModel(
      paciente: map['paciente'],
      responsavelPactuacao: map['responsavelPactuacao'],
      prazo: map['prazo'],
      familia: map['familia'],
      responsavel: map['responsavel'],
      foto: map['foto'],
      data: DateTime.parse(map['data']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paciente': paciente,
      'responsavelPactuacao': responsavelPactuacao,
      'prazo': prazo,
      'familia': familia,
      'responsavel': responsavel,
      'foto': foto,
      'data': data.toIso8601String(),
    };
  }
}

class ListPactuacaoModel {
  List<PactuacaoModel> listPactuacao;

  ListPactuacaoModel({required this.listPactuacao});

  factory ListPactuacaoModel.fromMap(Map<String, dynamic> map) {
    return ListPactuacaoModel(
      listPactuacao: List<PactuacaoModel>.from(
        map['listPactuacao']?.map((x) => PactuacaoModel.fromMap(x)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'listPactuacao': listPactuacao.map((x) => x.toMap()).toList(),
    };
  }
}
