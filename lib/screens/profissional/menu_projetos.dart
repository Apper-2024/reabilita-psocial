import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/profissional/projetos.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/header.dart';
import 'package:reabilita_social/widgets/inputText/text_search.dart';
import 'package:reabilita_social/widgets/menu_tab.dart';

class MenuProjetos extends StatefulWidget {
  const MenuProjetos({super.key});

  @override
  State<MenuProjetos> createState() => _MenuProjetosState();
}

TabController? _controller;
List<Tab> _tabs = [
  const Tab(
    text: "Pacientes Cadastrados",
  ),
  const Tab(
    text: "Pacientes Pendentes",
  ),
];

class _MenuProjetosState extends State<MenuProjetos> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      print(_query);
      _query = _searchController.text;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _searchController.dispose();
    super.dispose();
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
              Header(
                // imageUrl:
                //     'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                notificationCount: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tenha acesso aos projetos criados',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: preto1,
                ),
              ),
              const SizedBox(height: 16),
              TextSearch(hintText: 'Procure o nome do paciente', controller: _searchController),
              const SizedBox(height: 16),
              MenuTab(tabs: _tabs, controller: _controller!),
              const SizedBox(height: 60),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: [
                    ProjetosScreen(titulo: 'cadastrado', pesquisa: _query),
                    ProjetosScreen(titulo: 'novo', pesquisa: _query)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Navigator.pushNamed(context, '/cadastroProjeto');
          },
          label: const Text(
            'Adicionar Projeto',
            style: TextStyle(color: background),
          ),
          icon: const Icon(Icons.add, color: background),
          backgroundColor: verde1),
    );
  }
}
