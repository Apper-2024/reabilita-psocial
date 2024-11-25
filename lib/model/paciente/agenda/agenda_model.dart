class AgendaModel {
  DateTime data;
  String pauta;
  String participantes;

  AgendaModel({
    required this.data,
    required this.pauta,
    required this.participantes,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toIso8601String(),
      'pauta': pauta,
      'participantes': participantes,
    };
  }

  factory AgendaModel.fromMap(Map<String, dynamic> map) {
    return AgendaModel(
      data: DateTime.parse(map['data']),
      pauta: map['pauta'],
      participantes: map['participantes'],
    );
  }
}

class ListaAgendaModel {
  List<AgendaModel> listaAgenda;

  ListaAgendaModel({
    required this.listaAgenda,
  });

  Map<String, dynamic> toMap() {
    return {
      'listaAgenda': listaAgenda.map((x) => x.toMap()).toList(),
    };
  }

  factory ListaAgendaModel.fromMap(Map<String, dynamic> map) {
    return ListaAgendaModel(
      listaAgenda: List<AgendaModel>.from(map['listaAgenda']?.map((x) => AgendaModel.fromMap(x))),
    );
  }
}