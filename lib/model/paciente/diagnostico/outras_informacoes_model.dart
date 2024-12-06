class OutrasInformacoesModel {
  List<String>? outrasInformacoes;

  OutrasInformacoesModel({this.outrasInformacoes});

  factory OutrasInformacoesModel.fromMap(Map<String, dynamic> map) {
    return OutrasInformacoesModel(
      outrasInformacoes: map['outrasInformacoes'] != null
          ? List<String>.from(map['outrasInformacoes'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'outrasInformacoes': outrasInformacoes,
    };
  }
}