import 'package:cloud_firestore/cloud_firestore.dart';

class AgendaList {
  Timestamp? dataCriacao;
  String? pauta;
  String? participantes;

  AgendaList({
    this.dataCriacao,
    this.pauta,
    this.participantes,
  });

  Map<String, dynamic> toMap() {
    return {
      'dataCriacao': dataCriacao,
      'pauta': pauta,
      'participantes': participantes,
    };
  }

  factory AgendaList.fromMap(Map<String, dynamic> map) {
    return AgendaList(
      dataCriacao: map['dataCriacao'],
      pauta: map['pauta'],
      participantes: map['participantes'],
    );
  }
}

class AgendaModel {
  List<AgendaList>? listaAgendaModel;

  AgendaModel({this.listaAgendaModel});

  Map<String, dynamic> toMap() {
    return {
      'listaAgendaModel': listaAgendaModel?.map((agenda) => agenda.toMap()).toList(),
    };
  }

  factory AgendaModel.fromMap(Map<String, dynamic> map) {
    return AgendaModel(
      listaAgendaModel: List<AgendaList>.from(
        map['listaAgendaModel']?.map((item) => AgendaList.fromMap(item)) ?? [],
      ),
    );
  }
}