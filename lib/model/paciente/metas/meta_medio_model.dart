import 'package:reabilita_social/model/paciente/metas/meta_model.dart';

class MetaMedioModel {
  List<MetaModel> metaMedioPrazo;

  MetaMedioModel({required this.metaMedioPrazo});

  factory MetaMedioModel.fromMap(Map<String, dynamic> map) {
    return MetaMedioModel(
      metaMedioPrazo: List<MetaModel>.from(
        map['metaMedioPrazo'].map((item) => MetaModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metaMedioPrazo': metaMedioPrazo.map((item) => item.toMap()).toList(),
    };
  }
}