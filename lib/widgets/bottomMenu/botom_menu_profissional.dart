import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/profissional/evolucao.dart';
import 'package:reabilita_social/screens/profissional/home.dart';
import 'package:reabilita_social/screens/profissional/menu_projetos.dart';
import 'package:reabilita_social/screens/profissional/perfil.dart';
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
      backgroundColor: Colors.white, // Substitua 'branco' por Colors.white
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          HomeScreen(),
          MenuProjetos(),
          EvolucaoScreen(),
          PerfilScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: setPaginaAtual,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: paginaAtual == 0 ? Colors.green : Colors.grey),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded, color: paginaAtual == 1 ? Colors.green : Colors.grey),
            label: 'Projetos',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart, color: paginaAtual == 2 ? Colors.green : Colors.grey),
            label: 'Evolução',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: paginaAtual == 3 ? Colors.green : Colors.grey),
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
