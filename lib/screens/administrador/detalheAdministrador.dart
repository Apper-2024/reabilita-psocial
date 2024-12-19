import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/administrador/homeAdministrador.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/snack/snack_sucesso.dart';
import 'package:reabilita_social/widgets/botao/botaoStatus.dart';
import 'package:reabilita_social/widgets/informacaoTitle.dart';

class DetalheAdministrador extends StatefulWidget {
  final String? uidDocumento;
  final String? userType;

  const DetalheAdministrador({
    super.key,
    this.uidDocumento,
    this.userType,
  });

  @override
  _DetalheAdministradorState createState() => _DetalheAdministradorState();
}

class _DetalheAdministradorState extends State<DetalheAdministrador> {
  bool _isLoading = false;
  Map<String, dynamic>? _userData;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final String collection = widget.userType == 'Administrador'
          ? 'Administrador'
          : 'Profissionais';

      final docSnapshot = await _firestore
          .collection(collection)
          .doc(widget.uidDocumento)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          _userData = docSnapshot.data();
        });
      } else {
        _showError('${widget.userType} não encontrado!');
      }
    } catch (e) {
      _showError('Erro ao carregar os dados: $e');
    }
  }

  Future<void> _atualizarStatus(String novoStatus) async {
    setState(() => _isLoading = true);

    try {
      final String collection = widget.userType == 'Administrador'
          ? 'Administrador'
          : 'Profissionais';

      await _firestore
          .collection(collection)
          .doc(widget.uidDocumento)
          .update({'statusConta': novoStatus});

      snackSucesso(
        context,
        novoStatus == 'ativo'
            ? 'Usuário ativado com sucesso!'
            : 'Usuário suspenso!',
      );

      setState(() {
        _userData!['statusConta'] = novoStatus;
      });
    } catch (e) {
      _showError('Erro ao atualizar status: $e');
    }

    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_userData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final status = _userData!['statusConta'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: background,
        automaticallyImplyLeading: false, // Remove seta padrão
        title: Text('Detalhes do ${widget.userType}'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/usuariosAdministrador");
          
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                _userData!['urlFoto'] ?? 'https://via.placeholder.com/200',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            InfoTile(title: 'Nome', value: _userData!['nome']),
            InfoTile(title: 'Email', value: _userData!['email']),
            InfoTile(title: 'Telefone', value: _userData!['telefone']),
            InfoTile(title: 'Status', value: _userData!['statusConta']),
            if (_userData!.containsKey('cpf'))
              InfoTile(title: 'CPF', value: _userData!['cpf']),
            if (_userData!.containsKey('profissao'))
              InfoTile(title: 'Profissão', value: _userData!['profissao']),
            if (_userData!.containsKey('localTrabalho'))
              InfoTile(
                  title: 'Local de Trabalho',
                  value: _userData!['localTrabalho']),
            if (_userData!.containsKey('raca'))
              InfoTile(title: 'Raça', value: _userData!['raca']),
            const SizedBox(height: 16),

            if (_userData!.containsKey('endereco'))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Endereço',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InfoTile(
                      title: 'Rua',
                      value: _userData!['endereco']['rua'] ?? 'N/A'),
                  InfoTile(
                      title: 'Número',
                      value: _userData!['endereco']['numero'] ?? 'N/A'),
                  InfoTile(
                      title: 'Bairro',
                      value: _userData!['endereco']['bairro'] ?? 'N/A'),
                  InfoTile(
                      title: 'Complemento',
                      value: _userData!['endereco']['complemento'] ?? 'N/A'),
                  InfoTile(
                      title: 'Cidade',
                      value: _userData!['endereco']['cidade'] ?? 'N/A'),
                  InfoTile(
                      title: 'Estado',
                      value: _userData!['endereco']['estado'] ?? 'N/A'),
                  InfoTile(
                      title: 'CEP',
                      value: _userData!['endereco']['cep'] ?? 'N/A'),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: StatusButton(
          status: status,
          isLoading: _isLoading,
          onPressed: () => _atualizarStatus(
            status == 'suspenso' ? 'ativo' : 'suspenso',
          ),
        ),
      ),
    );
  }
}
