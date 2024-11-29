import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/administrador/profissionais_aceitos.dart';
import 'package:reabilita_social/screens/administrador/profissionais_pendentes.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/menu_tab.dart';
import 'package:reabilita_social/widgets/titulo_principal.dart';


class MenuProfissionais extends StatefulWidget {
  const MenuProfissionais({super.key});

  @override
  State<MenuProfissionais> createState() => _MenuProfissionaisState();
}

TabController? _controller;
List<Tab> _tabs = [
  const Tab(
    text: "Profissionais Aceitos",
  ),
  const Tab(
    text: "Profissionais Pendentes",
  ),
];

class _MenuProfissionaisState extends State<MenuProfissionais> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: branco,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 32, right: 32),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const TituloPrincipal(
                  pesquisa: true,
                  titulo: "Profissionais",
                  items: ['Administrador', 'Sair'],
                ),
              const SizedBox(height: 32),

              MenuTab(tabs: _tabs, controller: _controller!),
              const SizedBox(height: 60),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: const [ProfissionaisAceitosScreen(), ProfissionaisPendentesScreen()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
