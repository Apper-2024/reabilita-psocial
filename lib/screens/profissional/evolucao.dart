import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';
import 'package:reabilita_social/provider/paciente_provider.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/services/firebase_service.dart';
import 'package:reabilita_social/widgets/card/card_evolu%C3%A7%C3%A3o.dart';
import '../../utils/colors.dart';
import '../../widgets/header.dart';

class EvolucaoScreen extends StatefulWidget {
  const EvolucaoScreen({
    super.key,
  });

  @override
  _EvolucaoScreenState createState() => _EvolucaoScreenState();
}

final FirebaseFirestore db = FirebaseService().db;
final ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;
PacienteProvider pacienteProvider = PacienteProvider.instance;
Query _baseQuery = db
    .collection("Pacientes")
    .where('dadosPacienteModel.uidProfisional', isEqualTo: profissionalProvider.profissional!.uidProfissional)
    .orderBy('dadosPacienteModel.dataCriacao', descending: true);

class _EvolucaoScreenState extends State<EvolucaoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              const SizedBox(height: 16),
              const Text(
                'Tenha a evoluções dos pacientes',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: preto1,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
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

                  return ListView.builder(
                    itemCount: pacientes.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final paciente = pacientes[index];
                      return CardEvolucao(
                        imageUrl: paciente.dadosPacienteModel.urlFoto,
                        nome: paciente.dadosPacienteModel.nome,
                        onTap: () {
                          pacienteProvider.setPaciente(paciente);
                          Navigator.pushNamed(context, "/evolucaoPaciente");
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) => const EvolucaoPacientePage()));
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
