class IntervencoesModel {
  String problema;
  List<ListIntervencoesModel> listIntervencoes;

  IntervencoesModel({required this.problema, required this.listIntervencoes});

  factory IntervencoesModel.fromMap(Map<String, dynamic> map) {
    return IntervencoesModel(
      problema: map['problema'],
      listIntervencoes: List<ListIntervencoesModel>.from(
        map['listIntervencoes'].map((item) => ListIntervencoesModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'problema': problema,
      'listIntervencoes': listIntervencoes.map((item) => item.toMap()).toList(),
    };
  }
}

class ListIntervencoesModel {
  String intervencoes;
  DateTime dataCriacao;
  String nomeResponsavel;
  String meta;
  String prazo;
  DateTime data;

  ListIntervencoesModel({
    required this.intervencoes,
    required this.dataCriacao,
    required this.nomeResponsavel,
    required this.meta,
    required this.prazo,
    required this.data,
  });

  factory ListIntervencoesModel.fromMap(Map<String, dynamic> map) {
    return ListIntervencoesModel(
      intervencoes: map['intervencoes'],
      dataCriacao: DateTime.parse(map['dataCriacao']),
      nomeResponsavel: map['nomeResponsavel'],
      meta: map['meta'],
      prazo: map['prazo'],
      data: DateTime.parse(map['data']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'intervencoes': intervencoes,
      'dataCriacao': dataCriacao.toIso8601String(),
      'nomeResponsavel': nomeResponsavel,
      'meta': meta,
      'prazo': prazo,
      'data': data.toIso8601String(),
    };
  }
}