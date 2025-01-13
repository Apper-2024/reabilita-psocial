import 'package:cloud_firestore/cloud_firestore.dart';

class Problema {
  String? problema;
  Timestamp? dataCriacao;

  Problema({this.problema, this.dataCriacao});

  factory Problema.fromMap(Map<String, dynamic> map) {
    return Problema(
      problema: map['problema'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'problema': problema,
      'dataCriacao': dataCriacao,
    };
  }
}

class ProblemaModel {
  List<Problema>? problema;

  ProblemaModel({this.problema});

  factory ProblemaModel.fromMap(Map<String, dynamic> map) {
    return ProblemaModel(
      problema: map['problema'] != null
          ? List<Problema>.from(map['problema'].map((item) => Problema.fromMap(item)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'problema': problema?.map((potencialidade) => potencialidade.toMap()).toList(),
    };
  }
}