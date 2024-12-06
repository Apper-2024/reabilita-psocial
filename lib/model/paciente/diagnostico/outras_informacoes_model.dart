class OutrasInformacoesDiagnosticoModel {
  List<String>? outrasInformacoes;

  OutrasInformacoesDiagnosticoModel({this.outrasInformacoes});

  factory OutrasInformacoesDiagnosticoModel.fromMap(Map<String, dynamic> map) {
    return OutrasInformacoesDiagnosticoModel(
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