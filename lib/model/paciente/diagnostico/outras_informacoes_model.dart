class OutrasInformacoesModel {
  List<String> outrasInformacoes;

  OutrasInformacoesModel({required this.outrasInformacoes});

  factory OutrasInformacoesModel.fromMap(Map<String, dynamic> map) {
    return OutrasInformacoesModel(
      outrasInformacoes: List<String>.from(map['outrasInformacoes']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'outrasInformacoes': outrasInformacoes,
    };
  }
}