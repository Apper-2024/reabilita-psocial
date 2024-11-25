class DiagnosticoMultiprofissionais {
  List<String> diagnosticos;
  DateTime dataCriacao;
  String nomeResponsavel;
  String profissaoResponsavel;
  String cpf;

  DiagnosticoMultiprofissionais({
    required this.diagnosticos,
    required this.dataCriacao,
    required this.nomeResponsavel,
    required this.profissaoResponsavel,
    required this.cpf,
  });

  factory DiagnosticoMultiprofissionais.fromMap(Map<String, dynamic> map) {
    return DiagnosticoMultiprofissionais(
      diagnosticos: List<String>.from(map['diagnosticos']),
      dataCriacao: DateTime.parse(map['dataCriacao']),
      nomeResponsavel: map['nomeResponsavel'],
      profissaoResponsavel: map['profissaoResponsavel'],
      cpf: map['cpf'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'diagnosticos': diagnosticos,
      'dataCriacao': dataCriacao.toIso8601String(),
      'nomeResponsavel': nomeResponsavel,
      'profissaoResponsavel': profissaoResponsavel,
      'cpf': cpf,
    };
  }
}

class HistoriaCasoModel {
  String historia;
  List<DiagnosticoMultiprofissionais> diagnosticos;
  List<String> foto;

  HistoriaCasoModel({
    required this.historia,
    required this.diagnosticos,
    required this.foto,
  });

  factory HistoriaCasoModel.fromMap(Map<String, dynamic> map) {
    return HistoriaCasoModel(
      historia: map['historia'],
      diagnosticos: List<DiagnosticoMultiprofissionais>.from(
        map['diagnosticos'].map((item) => DiagnosticoMultiprofissionais.fromMap(item)),
      ),
      foto: List<String>.from(map['foto']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'historia': historia,
      'diagnosticos': diagnosticos.map((item) => item.toMap()).toList(),
      'foto': foto,
    };
  }
}