import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class ItemConteudo {
  final String titulo;
  final VoidCallback onTap;
  final VoidCallback onTap2;

  ItemConteudo({required this.titulo, required this.onTap, required this.onTap2});
}

class DetalhesPaciente extends StatelessWidget {
  final String nomePaciente;
  final String dataCriacao;
  final String titulo;
  final String categoria;
  final List<ItemConteudo> conteudos;

  const DetalhesPaciente({
    super.key,
    required this.nomePaciente,
    required this.dataCriacao,
    required this.conteudos,
    required this.titulo,
    required this.categoria,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          titulo,
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: () {
              // Coloque a lógica desejada para o botão da AppBar
              print("teste");
            },
          ),
        ],

        toolbarHeight: 100.0, // Define a altura desejada da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://wendellcarvalho.com.br/wp-content/uploads/2023/07/Saiba-o-que-e-uma-pessoa-temperamental-e-como-esse-comportamento-pode-afetar-diferentes-areas-da-vida.jpg"),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                nomePaciente,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'Paciente criada no dia $dataCriacao pelo Dr. Lorem Ipsum',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Exibe a lista de itens dinâmicos
            Expanded(
              child: ListView.builder(
                itemCount: conteudos.length,
                itemBuilder: (context, index) {
                  return ItemLista(conteudo: conteudos[index]);
                },
              ),
            ),
          ],
        ),
      ),

      // FloatingActionButton para adicionar novas ações
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Floating Action Button pressionado');
          // Adicione a lógica para a ação do botão
        },
        backgroundColor: Colors.green[900],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class ItemLista extends StatelessWidget {
  final ItemConteudo conteudo;

  const ItemLista({super.key, required this.conteudo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: conteudo.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha ao topo para textos longos
          children: [
            Expanded(
              // Permite que o texto ocupe o espaço disponível
              child: Text(
                conteudo.titulo,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange[100],
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: verde1,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
