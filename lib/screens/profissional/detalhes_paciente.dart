import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/provider/paciente_provider.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/formaters/formater_data.dart';

class ItemConteudo {
  final String titulo;
  final VoidCallback onTap;
  final VoidCallback onTap2;

  ItemConteudo({required this.titulo, required this.onTap, required this.onTap2});
}

class DetalhesPaciente extends StatelessWidget {
  final List<ItemConteudo> conteudos;
  final bool visible;
  final void Function()? onPressed;
  const DetalhesPaciente({
    super.key,
    required this.conteudos,
    required this.visible,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final pacienteProvider = Provider.of<PacienteProvider>(context, listen: true);
    DadosPacienteModel pacienteModel = pacienteProvider.paciente!.dadosPacienteModel;
    ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;

    return Scaffold(
      backgroundColor: background,
      floatingActionButton: Visibility(
        visible: visible,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: Colors.green[900],
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          pacienteModel.nome,
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,

        toolbarHeight: 100.0, // Define a altura desejada da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(pacienteProvider.paciente!.dadosPacienteModel.urlFoto),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                pacienteModel.nome,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'Paciente criada no dia ${formatTimesTamp(pacienteModel.dataCriacao)} pelo ${profissionalProvider.profissional!.nome}',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
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
