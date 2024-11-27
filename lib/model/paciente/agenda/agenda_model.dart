import 'package:cloud_firestore/cloud_firestore.dart';

class AgendaModel {
  Timestamp data;
  String pauta;
  String participantes;

  AgendaModel({
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

  factory AgendaModel.fromMap(Map<String, dynamic> map) {
    return AgendaModel(
      data: map['data'],
      pauta: map['pauta'],
      participantes: map['participantes'],
    );
  }
}

