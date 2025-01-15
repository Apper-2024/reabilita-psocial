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

  void updateFromList(List<String> values) {
    if (values.isNotEmpty) {
      desejos = values[0];
      if (sonhoVida != null) {
        for (int i = 1; i < values.length; i++) {
          if (i - 1 < sonhoVida!.length) {
            sonhoVida![i - 1].updateFromValue(values[i]);
          } else if (values[i].isNotEmpty) {
            sonhoVida!.add(SonhoVidaModel(sonhoVida: values[i], dataCriacao: Timestamp.now()));
          }
        }
        // Remove sonhos extras se a nova lista for menor
        if (sonhoVida!.length > values.length - 1) {
          sonhoVida!.removeRange(values.length - 1, sonhoVida!.length);
        }
      } else {
        sonhoVida = values.sublist(1).where((value) => value.isNotEmpty).map((value) => SonhoVidaModel(sonhoVida: value, dataCriacao: Timestamp.now())).toList();
      }
    }
  }
}
class SonhoVidaModel {
  String? sonhoVida;
  Timestamp? dataCriacao;

  SonhoVidaModel({this.sonhoVida, this.dataCriacao});

  factory SonhoVidaModel.fromMap(Map<String, dynamic> map) {
    return SonhoVidaModel(
      sonhoVida: map['sonhoVida'],
      dataCriacao: map['dataCriacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sonhoVida': sonhoVida,
      'dataCriacao': dataCriacao,
    };
  }

  void updateFromValue(String value) {
    sonhoVida = value;
  }
}