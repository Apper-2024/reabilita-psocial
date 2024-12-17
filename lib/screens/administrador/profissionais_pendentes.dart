import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_profissional_adm.dart';

class ProfissionaisPendentesScreen extends StatefulWidget {
  const ProfissionaisPendentesScreen({super.key});

  @override
  _ProfissionaisPendentesScreenState createState() => _ProfissionaisPendentesScreenState();
}

class _ProfissionaisPendentesScreenState extends State<ProfissionaisPendentesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _fetchPendentes() async {
    try {
      List<Map<String, dynamic>> allPendentes = [];

      // Busca pendentes na coleção Profissionais
      QuerySnapshot profSnapshot =
          await _firestore.collection('Profissionais').where('statusConta', isEqualTo: 'analise').get();

      allPendentes.addAll(profSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['uidDocumento'] = doc.id;
        data['tipoUsuario'] = 'Profissional';
        return data;
      }));

      // Busca pendentes na coleção Administrador
      QuerySnapshot adminSnapshot =
          await _firestore.collection('Administrador').where('statusConta', isEqualTo: 'analise').get();

      allPendentes.addAll(adminSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['uidDocumento'] = doc.id;
        data['tipoUsuario'] = 'Administrador';
        return data;
      }));

      debugPrint('Total de pendentes carregados: ${allPendentes.length}');
      return allPendentes;
    } catch (e) {
      debugPrint('Erro ao buscar profissionais pendentes: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Título centralizado no topo
          const Text(
            'Veja os profissionais pendentes',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: preto1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Espaço para os cards (com FutureBuilder)
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchPendentes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar dados: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final profissionaisPendentes = snapshot.data;

                if (profissionaisPendentes == null || profissionaisPendentes.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum profissional pendente encontrado.',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                // Lista de cards
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: profissionaisPendentes.length,
                  itemBuilder: (context, index) {
                    final profissional = profissionaisPendentes[index];

                    return CardProfissionaisAdm(
                      nome: profissional['nome'] ?? 'Sem nome',
                      email: profissional['email'] ?? 'Sem email',
                      telefone: profissional['telefone'] ?? 'Sem telefone',
                      urlFoto: profissional['urlFoto'] ?? 'https://via.placeholder.com/150',
                      status: profissional['statusConta'] ?? 'Sem status',
                      uidDocumento: profissional['uidDocumento'],
                      tipoUsuario: profissional['tipoUsuario']?.toString() ?? 'Desconhecido', // Corrigido
                      onTap: () {
                        debugPrint('Card selecionado: ${profissional['nome']} (${profissional['uidDocumento']})');
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
