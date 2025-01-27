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
    return Scaffold(
      backgroundColor: background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/cadastroProjeto');
        },
        backgroundColor: verde1,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          "Adicionar Projeto",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Header(),
            const SizedBox(height: 16),
            const Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.folder_open,
                  color: bege,
                  size: 80,
                ),
                Text(
                  'Tenha acesso aos projetos criados.',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextSearch(hintText: 'Procure o nome do paciente', controller: _searchController),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _baseQuery.snapshots(),
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

                  // Filtrar os pacientes no lado do cliente
                  final List<PacienteModel> pacientesFiltrados = pacientes.where((paciente) {
                    return paciente.dadosPacienteModel.nome.toLowerCase().contains(_query.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    itemCount: pacientesFiltrados.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final paciente = pacientesFiltrados[index];
                      return CardProjeto(
                        uid: paciente.dadosPacienteModel.uidDocumento,
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
