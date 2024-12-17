// projetos.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';
import 'package:reabilita_social/provider/paciente_provider.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/services/firebase_service.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_projeto.dart';
import 'package:reabilita_social/widgets/header.dart';
import 'package:reabilita_social/widgets/inputText/text_search.dart';

class ProjetosScreen extends StatefulWidget {
  const ProjetosScreen({
    super.key,
  });

  @override
  _ProjetosScreenState createState() => _ProjetosScreenState();
}

class _ProjetosScreenState extends State<ProjetosScreen> {
  final FirebaseFirestore db = FirebaseService().db;
  final ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  late Query _baseQuery;
  PacienteProvider pacienteProvider = PacienteProvider.instance;
  @override
  void initState() {
    super.initState();
    _baseQuery = db
        .collection("Pacientes")
        .where('dadosPacienteModel.uidProfisional', isEqualTo: profissionalProvider.profissional!.uidProfissional)
        .orderBy('dadosPacienteModel.dataCriacao', descending: true);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      print(_query);
      _query = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Query query = _baseQuery;

    if (_searchController.text.isNotEmpty) {
      query = query
          .where('dadosPacienteModel.nome', isGreaterThanOrEqualTo: _searchController.text)
          .where('dadosPacienteModel.nome', isLessThanOrEqualTo: '${_searchController.text}\uf8ff');
    }

    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Header(
           
            ),
            const SizedBox(height: 16),
            const Text(
              'Tenha acesso aos projetos criados',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                color: preto1,
              ),
            ),
            const SizedBox(height: 16),
            TextSearch(hintText: 'Procure o nome do paciente', controller: _searchController),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: query.snapshots(),
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

                  final List<PacienteModel> pacientes = snapshot.data!.docs.map((doc) {
                    return PacienteModel.fromMap(doc.data() as Map<String, dynamic>);
                  }).toList();

                  return ListView.builder(
                    itemCount: pacientes.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final paciente = pacientes[index];
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
