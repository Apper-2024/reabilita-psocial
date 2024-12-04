class EnderecoModel {
  String rua;
  String numero;
  String bairro;
  String estado;
  String cidade;
  String cep;

  String? complemento;

  EnderecoModel({
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.estado,
    required this.cidade,
    required this.cep,
    this.complemento,
  });

  factory EnderecoModel.fromMap(Map<String, dynamic> data) {
    return EnderecoModel(
      rua: data['rua'] ?? '',
      numero: data['numero'] ?? '',
      bairro: data['bairro'] ?? '',
      estado: data['estado'] ?? '',
      cidade: data['cidade'] ?? '',
      cep: data['cep'] ?? '',
      complemento: data['complemento'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'estado': estado,
      'cidade': cidade,
      'cep': cep,
      'complemento': complemento,
    };
  }
}
