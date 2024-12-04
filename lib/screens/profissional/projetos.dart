// projetos.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/enum/enum_status_conta.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';
import 'package:reabilita_social/provider/paciente_provider.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/services/firebase_service.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_projeto.dart';

class ProjetosScreen extends StatefulWidget {
  final String titulo;
  final String pesquisa;

  const ProjetosScreen({
    super.key,
    required this.titulo,
    required this.pesquisa,
  });

  @override
  _ProjetosScreenState createState() => _ProjetosScreenState();
}

class _ProjetosScreenState extends State<ProjetosScreen> {
  final FirebaseFirestore db = FirebaseService().db;
  final ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;

  late Query _baseQuery;
  PacienteProvider pacienteProvider = PacienteProvider.instance;
  @override
  void initState() {
    super.initState();

    _baseQuery = db
        .collection("Pacientes")
        .where('uidProfisional', isEqualTo: profissionalProvider.profissional!.uidProfissional);

    if (widget.titulo == 'cadastrado') {
      _baseQuery = _baseQuery.where('statusConta', isEqualTo: EnumStatusConta.ativo.name);
    } else {
      _baseQuery = _baseQuery.where('statusConta', isEqualTo: EnumStatusConta.naoCadastrada.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    Query query = _baseQuery;
    if (widget.pesquisa.isNotEmpty) {
      query = query
          .where('nome', isGreaterThanOrEqualTo: widget.pesquisa)
          .where('nome', isLessThanOrEqualTo: '${widget.pesquisa}\uf8ff');
    }

    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            snapshot.data!.docs.map((doc) {
              print(doc.data() as Map<String, dynamic>);
            }).toList();
            final List<PacienteModel> pacientes = snapshot.data!.docs.map((doc) {
              return PacienteModel.fromMap(doc.data() as Map<String, dynamic>);
            }).toList();

            return ListView.builder(
              itemCount: pacientes.length,
              itemBuilder: (context, index) {
                final paciente = pacientes[index];
                return CardProjeto(
                  onTap: () {
                    pacienteProvider.setPaciente(paciente);
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
    );
  }
}
