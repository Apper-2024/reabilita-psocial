import 'package:cloud_firestore/cloud_firestore.dart';

class DesejoModel {
  String? desejos;
  List<SonhoVidaModel>? sonhoVida;

  DesejoModel({this.desejos, this.sonhoVida});

  factory DesejoModel.fromMap(Map<String, dynamic> map) {
    return DesejoModel(
      desejos: map['desejos'],
      sonhoVida: map['sonhoVida'] != null
          ? List<SonhoVidaModel>.from(
              map['sonhoVida'].map((item) => SonhoVidaModel.fromMap(item)),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'desejos': desejos,
      'sonhoVida': sonhoVida?.map((item) => item.toMap()).toList(),
    };
  }
}

class SonhoVidaModel {
  List<String>? sonhoVida;
  Timestamp? dataCriacao;

  SonhoVidaModel({this.sonhoVida, this.dataCriacao});

  factory SonhoVidaModel.fromMap(Map<String, dynamic> map) {
    return SonhoVidaModel(
      sonhoVida: map['sonhoVida'] != null ? List<String>.from(map['sonhoVida']) : null,
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