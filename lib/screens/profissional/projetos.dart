import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/enum/enum_status_conta.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/services/firebase_service.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_projeto.dart';

class ProjetosScreen extends StatefulWidget {
  final String titulo;

  const ProjetosScreen({
    Key? key,
    required this.titulo,
  }) : super(key: key);

  @override
  _ProjetosScreenState createState() => _ProjetosScreenState();
}

class _ProjetosScreenState extends State<ProjetosScreen> {
  final FirebaseFirestore db = FirebaseService().db;
  final ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;

  late final Stream<QuerySnapshot> _pacientesStream;

  @override
  void initState() {
    super.initState();

    Query baseQuery = db
        .collection("Pacientes")
        .where('uidProfisional', isEqualTo: profissionalProvider.profissional!.uidProfissional);

    if (widget.titulo == 'cadastrado') {
      baseQuery = baseQuery.where('statusConta', isEqualTo: EnumStatusConta.ativo.name);
    } else {
      baseQuery = baseQuery.where('statusConta', isEqualTo: EnumStatusConta.naoCadastrada.name);
    }

    _pacientesStream = baseQuery.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _pacientesStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Algo deu errado'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Nenhum usuário encontrado"));
            }

            final List<DadosPacienteModel> pacientes = snapshot.data!.docs.map((doc) {
              return DadosPacienteModel.fromMap(doc.data() as Map<String, dynamic>);
            }).toList();

            return ListView.builder(
              itemCount: pacientes.length,
              itemBuilder: (context, index) {
                final paciente = pacientes[index];
                return CardProjeto(
                  foto: paciente.urlFoto,
                  nome: paciente.nome,
                  observacao: paciente.outrasInformacoes.observacao,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
