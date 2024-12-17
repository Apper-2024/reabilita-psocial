import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/profissional/evolucao.dart';
import 'package:reabilita_social/screens/profissional/home.dart';
import 'package:reabilita_social/screens/profissional/perfil.dart';
import 'package:reabilita_social/screens/profissional/projetos.dart';
import 'package:reabilita_social/utils/colors.dart';

class BottomMenuProfissional extends StatefulWidget {
  const BottomMenuProfissional({super.key});

  @override
  _BottomMenuProfissionalState createState() => _BottomMenuProfissionalState();
}

class _BottomMenuProfissionalState extends State<BottomMenuProfissional> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  void setPaginaAtual(int pagina) {
    setState(() {
      paginaAtual = pagina;
    });
    pc.jumpToPage(pagina);
  }

  @override
  void dispose() {
    pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          HomeScreen(),
          ProjetosScreen(),
          EvolucaoScreen(),
          PerfilScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: setPaginaAtual,
        backgroundColor: background,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: paginaAtual == 0 ? verde1 : Colors.grey),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded, color: paginaAtual == 1 ? verde1 : Colors.grey),
            label: 'Projetos',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart, color: paginaAtual == 2 ? verde1 : Colors.grey),
            label: 'Evolução',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: paginaAtual == 3 ? verde1 : Colors.grey),
            label: 'Perfil',
            backgroundColor: Colors.white,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: verde1,
        unselectedItemColor: cinza1,
        selectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins'),
      ),
    );
  }
}
