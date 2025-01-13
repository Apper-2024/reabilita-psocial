import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reabilita_social/screens/administrador/detalheAdministrador.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/card/card_profissional_adm.dart';

class ProfissionaisAceitosScreen extends StatefulWidget {
  const ProfissionaisAceitosScreen({super.key});

  @override
  _ProfissionaisAceitosScreenState createState() =>
      _ProfissionaisAceitosScreenState();
}

class _ProfissionaisAceitosScreenState
    extends State<ProfissionaisAceitosScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _selectedStatus = 'todos';
  String _selectedUserType = 'todos';

  Future<List<Map<String, dynamic>>> _fetchUsers(
      String status, String userType) async {
    try {
      List<Map<String, dynamic>> allUsers = [];

      if (userType == 'todos' || userType == 'Profissionais') {
        Query queryProfissionais = _firestore.collection('Profissionais');
        if (status != 'todos') {
          queryProfissionais =
              queryProfissionais.where('statusConta', isEqualTo: status);
        }
        QuerySnapshot snapshotProfissionais = await queryProfissionais.get();

        allUsers.addAll(snapshotProfissionais.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['uidDocumento'] = doc.id;
          data['tipoUsuario'] = 'Profissional';
          return data;
        }));
      }

      if (userType == 'todos' || userType == 'Administrador') {
        Query queryAdministradores = _firestore.collection('Administrador');
        if (status != 'todos') {
          queryAdministradores =
              queryAdministradores.where('statusConta', isEqualTo: status);
        }
        QuerySnapshot snapshotAdministradores =
            await queryAdministradores.get();

        allUsers.addAll(snapshotAdministradores.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['uidDocumento'] = doc.id;
          data['tipoUsuario'] = 'Administrador';
          return data;
        }));
      }

      return allUsers;
    } catch (e) {
      debugPrint('Erro ao buscar usuários: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          const Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.groups_rounded,
                  color: bege,
                  size: 70,
                ),
                Text(
                  'Gerencie todos os usuários do sistema.',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // filtrp
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    labelText: 'Filtrar por status',
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: verde1, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'todos', child: Text('Todos')),
                    DropdownMenuItem(value: 'ativo', child: Text('Ativo')),
                    DropdownMenuItem(
                        value: 'recusada', child: Text('Recusada')),
                    DropdownMenuItem(
                        value: 'suspenso', child: Text('Suspenso')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedUserType,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    labelText: 'Filtrar por tipo de usuário',
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: verde1, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'todos', child: Text('Todos')),
                    DropdownMenuItem(
                        value: 'Profissionais', child: Text('Profissionais')),
                    DropdownMenuItem(
                        value: 'Administrador', child: Text('Administradores')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUserType = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Lista de Cards
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchUsers(_selectedStatus, _selectedUserType),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar dados: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final users = snapshot.data;

                if (users == null || users.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum usuário encontrado.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                // Lista de cards
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return CardProfissionaisAdm(
                      nome: user['nome'] ?? 'Sem nome',
                      email: user['email'] ?? 'Sem email',
                      telefone: user['telefone'] ?? 'Sem telefone',
                      urlFoto:
                          user['urlFoto'] ?? 'https://via.placeholder.com/150',
                      status: user['statusConta'] ?? 'Sem status',
                      uidDocumento: user['uidDocumento'],
                      tipoUsuario: user['tipoUsuario'] ?? 'Desconhecido',
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetalheAdministrador(
                              uidDocumento: user['uidDocumento'],
                              userType: user['tipoUsuario'],
                            ),
                          ),
                        );

                        setState(() {});
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
