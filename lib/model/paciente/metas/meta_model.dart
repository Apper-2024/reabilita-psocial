class MetaModel {
  List<String> meta;
  DateTime dataCriacao;

  MetaModel({required this.meta, required this.dataCriacao});

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      meta: List<String>.from(map['meta']),
      dataCriacao: DateTime.parse(map['dataCriacao']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'meta': meta,
      'dataCriacao': dataCriacao.toIso8601String(),
    };
  }
}