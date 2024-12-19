import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reabilita_social/screens/administrador/adicionarUsuario.dart';
import 'package:reabilita_social/screens/administrador/profissionais_aceitos.dart';
import 'package:reabilita_social/screens/administrador/profissionais_pendentes.dart';
import 'package:reabilita_social/screens/auth/login.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';

class ProfissionaisPage extends StatefulWidget {
  const ProfissionaisPage({super.key});

  @override
  State<ProfissionaisPage> createState() => _ProfissionaisPageState();
}

class _ProfissionaisPageState extends State<ProfissionaisPage> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  // Lógica de logout
  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context, "/login");
      
    } catch (e) {
      debugPrint("Erro ao fazer logout: $e");
      snackErro(context, "Erro ao sair. Tente novamente.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0,
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          title: const Text(
            "Profissionais",
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            PopupMenuButton<String>(
              color: Colors.white, // Fundo branco
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onSelected: (value) {
                if (value == 'Administrador') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Você é um Administrador."),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (value == 'Sair') {
                  _logout(); // Chama a lógica de logout
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'Administrador',
                  child: Text('Administrador'),
                ),
                const PopupMenuItem(
                  value: 'Sair',
                  child: Text('Sair'),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: branco,
        body: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TabBar(
                  controller: _controller,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.green,
                  isScrollable: true,
                  tabs: _tabs,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: const [
                  ProfissionaisAceitosScreen(),
                  ProfissionaisPendentesScreen(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/adicionarAdministrador");
        
          },
          backgroundColor: verde1,
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            "Adicionar",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

final List<Tab> _tabs = [
  const Tab(text: "Todos os Profissionais"),
  const Tab(text: "Profissionais Pendentes"),
];
