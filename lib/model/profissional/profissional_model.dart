import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reabilita_social/model/endereco_model.dart';

class ProfissionalModel {
  String nome;
  String email;
  String telefone;
  String? genero;
  String cpf;
  String? raca;
  String? profissao;
  String? localTrabalho;
  EnderecoModel endereco;
  String tipoUsuario;
  String statusConta;
  String urlFoto;
  Timestamp dataNascimento;
  String uidProfissional;

  ProfissionalModel({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.genero,
    required this.cpf,
    required this.raca,
    required this.profissao,
    required this.localTrabalho,
    required this.endereco,
    required this.tipoUsuario,
    required this.statusConta,
    required this.dataNascimento,
    required this.urlFoto,
    required this.uidProfissional,
    
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'genero': genero,
      'cpf': cpf,
      'raca': raca,
      'profissao': profissao,
      'localTrabalho': localTrabalho,
      'endereco': endereco.toMap(),
      'tipoUsuario': tipoUsuario,
      'statusConta': statusConta,
      'dataNascimento': dataNascimento,
      'urlFoto': urlFoto,
      'uidProfissional': uidProfissional,
    };
  }

  factory ProfissionalModel.fromMap(Map<String, dynamic> map) {
    return ProfissionalModel(
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      genero: map['genero'],
      cpf: map['cpf'],
      raca: map['raca'],
      profissao: map['profissao'],
      localTrabalho: map['localTrabalho'],
      endereco: EnderecoModel.fromMap(map['endereco']),
      tipoUsuario: map['tipoUsuario'],
      statusConta: map['statusConta'],
      dataNascimento: map['dataNascimento'],
      urlFoto: map['urlFoto'],
      uidProfissional: map['uidProfissional'],
    );
  }
}
