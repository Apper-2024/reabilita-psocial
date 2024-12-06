import 'package:cloud_firestore/cloud_firestore.dart';

class AgendaList {
  Timestamp data;
  String pauta;
  String participantes;

  AgendaList({
    required this.data,
    required this.pauta,
    required this.participantes,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'pauta': pauta,
      'participantes': participantes,
    };
  }

  factory AgendaList.fromMap(Map<String, dynamic> map) {
    return AgendaList(
      data: map['data'],
      pauta: map['pauta'],
      participantes: map['participantes'],
    );
  }
}

class AgendaModel {
  List<AgendaList> agendas;

  AgendaModel({required this.agendas});

  Map<String, dynamic> toMap() {
    return {
      'agendas': agendas.map((agenda) => agenda.toMap()).toList(),
    };
  }

  factory AgendaModel.fromMap(Map<String, dynamic> map) {
    return AgendaModel(
      agendas: List<AgendaList>.from(
        map['agendas']?.map((item) => AgendaList.fromMap(item)) ?? [],
      ),
    );
  }
}