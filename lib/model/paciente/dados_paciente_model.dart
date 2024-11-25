import 'package:reabilita_social/model/endereco_model.dart';

class DadosPacienteModel {
  String nome;
  String email;
  String telefone;
  String genero;
  String cns;
  String profissao;
  String rendaMensal;
  EnderecoModel endereco;
  String tipoUsuario;
  String statusConta;
  String dataNascimento;
  String observacoes;
  bool pacienteCuratelado;
  String tecnicoReferencia;

  DadosPacienteModel({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.genero,
    required this.cns,
    required this.profissao,
    required this.rendaMensal,
    required this.endereco,
    required this.tipoUsuario,
    required this.statusConta,
    required this.dataNascimento,
    required this.observacoes,
    required this.pacienteCuratelado,
    required this.tecnicoReferencia,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'genero': genero,
      'cns': cns,
      'profissao': profissao,
      'rendaMensal': rendaMensal,
      'endereco': endereco.toMap(),
      'tipoUsuario': tipoUsuario,
      'statusConta': statusConta,
      'dataNascimento': dataNascimento,
      'observacoes': observacoes,
      'pacienteCuratelado': pacienteCuratelado,
      'tecnicoReferencia': tecnicoReferencia,
    };
  }

  factory DadosPacienteModel.fromMap(Map<String, dynamic> map) {
    return DadosPacienteModel(
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      genero: map['genero'],
      cns: map['cns'],
      profissao: map['profissao'],
      rendaMensal: map['rendaMensal'],
      endereco: EnderecoModel.fromMap(map['endereco']),
      tipoUsuario: map['tipoUsuario'],
      statusConta: map['statusConta'],
      dataNascimento: map['dataNascimento'],
      observacoes: map['observacoes'],
      pacienteCuratelado: map['pacienteCuratelado'],
      tecnicoReferencia: map['tecnicoReferencia'],
    );
  }
}
