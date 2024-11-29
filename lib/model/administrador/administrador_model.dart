import 'package:cloud_firestore/cloud_firestore.dart';

class AdministradorModel {
  String nome;
  String email;
  String telefone;
  String tipoUsuario;
  String statusConta;
  String uidAdministrador;
  Timestamp dataCriacao;

  AdministradorModel({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.tipoUsuario,
    required this.statusConta,
    required this.uidAdministrador,
    required this.dataCriacao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'tipoUsuario': tipoUsuario,
      'statusConta': statusConta,
      'uidAdministrador': uidAdministrador,
      'dataCriacao': dataCriacao,
    };
  }

  factory AdministradorModel.fromMap(Map<String, dynamic> map) {
    return AdministradorModel(
      nome: map['nome'] as String,
      email: map['email'] as String,
      telefone: map['telefone'] as String,
      tipoUsuario: map['tipoUsuario'] as String,
      statusConta: map['statusConta'] as String,
      uidAdministrador: map['uidAdministrador'] as String,
      dataCriacao: map['dataCriacao'],
    );
  }
}
