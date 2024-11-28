// import 'package:flutter/material.dart';
// import 'package:reabilita_social/screens/evolucao.dart';
// import 'package:reabilita_social/screens/home.dart';
// import 'package:reabilita_social/screens/perfil.dart';
// import 'package:reabilita_social/screens/projetos.dart';
// import 'package:reabilita_social/utils/colors.dart';

// class BotomMenuProfissional extends StatefulWidget {
//   const BotomMenuProfissional({super.key});

//   @override
//   _BotomMenuProfissionalState createState() => _BotomMenuProfissionalState();
// }

// class _BotomMenuProfissionalState extends State<BotomMenuProfissional> {
//   int _currentIndex = 0;
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const ProjetoScreen(),
//     const EvolucaoScreen(),
//     const PerfilScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, color: _currentIndex == 0 ? verde1 : cinza1),
//             label: 'Home',
//             backgroundColor: Colors.white,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people_alt_rounded, color: _currentIndex == 1 ? verde1 : cinza1),
//             label: 'Projetos',
//             backgroundColor: Colors.white,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bubble_chart, color: _currentIndex == 2 ? verde1 : cinza1),
//             label: 'Evolução',
//             backgroundColor: Colors.white,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person, color: _currentIndex == 3 ? verde1 : cinza1),
//             label: 'Perfil',
//             backgroundColor: Colors.white,
//           ),
//         ],
//         selectedItemColor: verde1,
//         unselectedItemColor: cinza1,
//         selectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
//         unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/evolucao.dart';
import 'package:reabilita_social/screens/home.dart';
import 'package:reabilita_social/screens/perfil.dart';
import 'package:reabilita_social/screens/projetos.dart';
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
          ProjetosScreen(),
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
