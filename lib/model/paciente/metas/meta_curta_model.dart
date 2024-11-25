import 'package:reabilita_social/model/paciente/metas/meta_model.dart';

class MetaCurtaModel {
  List<MetaModel> metaCurtoPrazo;

  MetaCurtaModel({required this.metaCurtoPrazo});

  factory MetaCurtaModel.fromMap(Map<String, dynamic> map) {
    return MetaCurtaModel(
      metaCurtoPrazo: List<MetaModel>.from(
        map['metaCurtoPrazo'].map((item) => MetaModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metaCurtoPrazo': metaCurtoPrazo.map((item) => item.toMap()).toList(),
    };
  }
}