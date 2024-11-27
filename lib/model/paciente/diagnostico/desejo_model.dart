import 'package:cloud_firestore/cloud_firestore.dart';

class DesejoModel {
  String desejos;
  List<SonhoVidaModel> sonhoVida;

  DesejoModel({required this.desejos, required this.sonhoVida});

  factory DesejoModel.fromMap(Map<String, dynamic> map) {
    return DesejoModel(
      desejos: map['desejos'],
      sonhoVida: List<SonhoVidaModel>.from(
        map['sonhoVida'].map((item) => SonhoVidaModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'desejos': desejos,
      'sonhoVida': sonhoVida.map((item) => item.toMap()).toList(),
    };
  }
}

class SonhoVidaModel {
  List<String> sonhoVida;
  Timestamp dataCriacao;

  SonhoVidaModel({required this.sonhoVida, required this.dataCriacao});

  factory SonhoVidaModel.fromMap(Map<String, dynamic> map) {
    return SonhoVidaModel(
      sonhoVida: List<String>.from(map['sonhoVida']),
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sonhoVida': sonhoVida,
      'dataCriacao': dataCriacao,
    };
  }
}