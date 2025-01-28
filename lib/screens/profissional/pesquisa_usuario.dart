// projetos.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';
import 'package:reabilita_social/provider/paciente_provider.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/services/firebase_service.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_projeto.dart';
import 'package:reabilita_social/widgets/inputText/text_search.dart';

class PesquisaUsuarioScreen extends StatefulWidget {
  const PesquisaUsuarioScreen({
    super.key,
  });

  @override
  _PesquisaUsuarioScreenState createState() => _PesquisaUsuarioScreenState();
}

class _PesquisaUsuarioScreenState extends State<PesquisaUsuarioScreen> {
  final FirebaseFirestore db = FirebaseService().db;
  final ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  late Query _baseQuery;
  PacienteProvider pacienteProvider = PacienteProvider.instance;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _baseQuery = db.collection('Pacientes');
  }

  @override
  Widget build(BuildContext context) {
    Query query = _baseQuery;

    if (_searchController.text.isNotEmpty) {
      query = query.where('url', isEqualTo: _searchController.text);
    }

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: const Text(
          'Pesquisar Usuário',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: preto1,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: preto1),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Procure pelo código do paciente',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                color: preto1,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: TextSearch(hintText: 'Digite o código do paciente', controller: _searchController)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _query = _searchController.text;
                    });
                  },
                  icon: const Icon(Icons.search, color: verde1),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_query.isNotEmpty)
              FutureBuilder<QuerySnapshot>(
                future: query.get(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(child: Text('Algo deu errado'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Nenhum usuário encontrado"));
                  }

                  final PacienteModel paciente =
                      PacienteModel.fromMap(snapshot.data!.docs.first.data() as Map<String, dynamic>);

                  return CardProjeto(
                    onTap: () {
                      pacienteProvider.setPaciente(paciente);

                      print(paciente);
                      print(pacienteProvider.paciente);
                      Navigator.pushNamed(context, '/telaPaciente');
                    },
                    foto: paciente.dadosPacienteModel.urlFoto,
                    nome: paciente.dadosPacienteModel.nome,
                    observacao: paciente.dadosPacienteModel.outrasInformacoes.observacao,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
