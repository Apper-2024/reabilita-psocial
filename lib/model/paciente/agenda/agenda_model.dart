import 'package:cloud_firestore/cloud_firestore.dart';

class AgendaList {
  List<String> email;
  String? participantes;
  String? pauta;
  Timestamp? dataCriacao;
  DateTime? selecionarData;
  

  AgendaList({
    required this.email,
    this.pauta,
    this.participantes,
    this.dataCriacao,
    this.selecionarData
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'pauta': pauta,
      'participantes': participantes,
      'dataCriacao': dataCriacao,
    };
  }

  factory AgendaList.fromMap(Map<String, dynamic> map) {
    return AgendaList(
      email: List<String>.from(map['email']),
      pauta: map['pauta'],
      participantes: map['participantes'],
      dataCriacao: map['dataCriacao'],
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
