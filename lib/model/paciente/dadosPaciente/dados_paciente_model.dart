import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reabilita_social/model/endereco_model.dart';

class DadosPacienteModel {
  String nome;
  String email;
  String telefone;
  String? genero;
  String cns;
  String profissao;
  String rendaMensal;
  EnderecoModel endereco;
  String tipoUsuario;
  String statusConta;
  String dataNascimento;
  String uidProfisional;
  String? uidPaciente;
  String uidDocumento;
  String urlFoto;
  Timestamp dataCriacao;
  OutrasInformacoesModel outrasInformacoes;

  DadosPacienteModel({
    required this.nome,
    required this.email,
    required this.telefone,
    this.genero,
    required this.cns,
    required this.profissao,
    required this.rendaMensal,
    required this.endereco,
    required this.tipoUsuario,
    required this.statusConta,
    required this.dataNascimento,
    required this.uidProfisional,
    this.uidPaciente,
    required this.uidDocumento,
    required this.urlFoto,
    required this.dataCriacao,
    required this.outrasInformacoes,
  });

  factory DadosPacienteModel.fromMap(Map<String, dynamic> data) {
    return DadosPacienteModel(
      nome: data['nome'] ?? '',
      email: data['email'] ?? '',
      telefone: data['telefone'] ?? '',
      genero: data['genero'] ?? '',
      cns: data['cns'] ?? '',
      profissao: data['profissao'] ?? '',
      rendaMensal: data['rendaMensal'] ?? '',
      endereco: EnderecoModel.fromMap(data['endereco'] ?? {}),
      tipoUsuario: data['tipoUsuario'] ?? '',
      statusConta: data['statusConta'] ?? '',
      dataNascimento: data['dataNascimento'] ?? '',
      uidProfisional: data['uidProfisional'] ?? '',
      uidPaciente: data['uidPaciente'] ?? '',
      uidDocumento: data['uidDocumento'] ?? '',
      urlFoto: data['urlFoto'] ?? '',
      dataCriacao: data['dataCriacao'] ?? Timestamp.now(),
      outrasInformacoes: OutrasInformacoesModel.fromMap(data['outrasInformacoes'] ?? {}),
    );
  }

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
      'uidProfisional': uidProfisional,
      'uidPaciente': uidPaciente,
      'uidDocumento': uidDocumento,
      'urlFoto': urlFoto,
      'dataCriacao': dataCriacao,
      'outrasInformacoes': outrasInformacoes.toMap(),
    };
  }
}

class OutrasInformacoesModel {
  String observacao;
  String tecnicoReferencia;
  String outrasInformacoes;
  bool pacienteCuratelado;

  OutrasInformacoesModel({
    required this.observacao,
    required this.tecnicoReferencia,
    required this.outrasInformacoes,
    required this.pacienteCuratelado,
  });

  Map<String, dynamic> toMap() {
    return {
      'observacao': observacao,
      'tecnicoReferencia': tecnicoReferencia,
      'outrasInformacoes': outrasInformacoes,
      'pacienteCuratelado': pacienteCuratelado,
    };
  }

  factory OutrasInformacoesModel.fromMap(Map<String, dynamic> map) {
    return OutrasInformacoesModel(
      observacao: map['observacao'] ?? '',
      tecnicoReferencia: map['tecnicoReferencia'] ?? '',
      outrasInformacoes: map['outrasInformacoes'] ?? '',
      pacienteCuratelado: map['pacienteCuratelado'] ?? false,
    );
  }
}
