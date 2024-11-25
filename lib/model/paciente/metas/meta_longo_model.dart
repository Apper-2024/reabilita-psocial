import 'package:reabilita_social/model/paciente/metas/meta_model.dart';

class MetaLongoModel {
  List<MetaModel> metaLongoPrazo;

  MetaLongoModel({required this.metaLongoPrazo});

  factory MetaLongoModel.fromMap(Map<String, dynamic> map) {
    return MetaLongoModel(
      metaLongoPrazo: List<MetaModel>.from(
        map['metaLongoPrazo'].map((item) => MetaModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metaLongoPrazo': metaLongoPrazo.map((item) => item.toMap()).toList(),
    };
  }
}