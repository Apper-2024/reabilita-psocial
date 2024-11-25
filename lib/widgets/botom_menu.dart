import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/evolucao.dart';
import 'package:reabilita_social/screens/home.dart';
import 'package:reabilita_social/screens/login.dart';
import 'package:reabilita_social/screens/perfil.dart';
import 'package:reabilita_social/screens/projetos.dart';
import 'package:reabilita_social/utils/colors.dart';

void main() {
  runApp(BotomMenu());
}

class BotomMenu extends StatefulWidget {
  @override
  _BotomMenuState createState() => _BotomMenuState();
}

class _BotomMenuState extends State<BotomMenu> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    ProjetoScreen(),
    EvolucaoScreen(),
    PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color:
                    _currentIndex == 0 ? AppColors.verde1 : AppColors.cinza1),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded,
                color:
                    _currentIndex == 1 ? AppColors.verde1 : AppColors.cinza1),
            label: 'Projetos',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart,
                color:
                    _currentIndex == 2 ? AppColors.verde1 : AppColors.cinza1),
            label: 'Evolução',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color:
                    _currentIndex == 3 ? AppColors.verde1 : AppColors.cinza1),
            label: 'Perfil',
            backgroundColor: Colors.white,
          ),
        ],
        selectedItemColor: AppColors.verde1,
        unselectedItemColor: AppColors.cinza1,
        selectedLabelStyle:
            TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
    );
  }
}
