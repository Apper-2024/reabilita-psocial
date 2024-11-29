class UsuarioModel {
  String email;
  String tipoUsuario;
  String uid;

  UsuarioModel({
    required this.email,
    required this.tipoUsuario,
    required this.uid,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> data) {
    return UsuarioModel(
      email: data['email'] ?? '',
      tipoUsuario: data['tipoUsuario'] ?? '',
      uid: data['uid'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'tipoUsuario': tipoUsuario,
      'uid': uid,
    };
  }
}
