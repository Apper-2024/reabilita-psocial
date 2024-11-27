class UsuarioModel {
  String email;
  String tipo;
  String uid;

  UsuarioModel({
    required this.email,
    required this.tipo,
    required this.uid,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> data) {
    return UsuarioModel(
      email: data['email'] ?? '',
      tipo: data['tipo'] ?? '',
      uid: data['uid'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'tipo': tipo,
      'uid': uid,
    };
  }
}
