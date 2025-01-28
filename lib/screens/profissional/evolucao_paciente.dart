import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reabilita_social/model/paciente/evolucao/evolucao_model.dart';
import 'package:reabilita_social/provider/paciente_provider.dart';
import 'package:reabilita_social/provider/profissional_provider.dart';
import 'package:reabilita_social/repository/paciente/gerencia_paciente_repository.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/snack/snack_atencao.dart';
import 'package:reabilita_social/utils/snack/snack_erro.dart';
import 'package:reabilita_social/utils/snack/snack_sucesso.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import 'package:table_calendar/table_calendar.dart';

class EvolucaoPacientePage extends StatefulWidget {
  const EvolucaoPacientePage({super.key});

  @override
  _EvolucaoPacientePageState createState() => _EvolucaoPacientePageState();
}

bool _carregando = false;

class _EvolucaoPacientePageState extends State<EvolucaoPacientePage> {
  DateTime selectedDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.week;
  TextEditingController comentarioController = TextEditingController();
  Map<DateTime, List<String>> comentarios = {};

  void _adicionarComentario() {
    PacienteProvider pacienteProvider = PacienteProvider.instance;
    EvolucaoModel? evolucao = pacienteProvider.paciente!.evolucoesModel;
    ProfissionalProvider profissionalProvider = ProfissionalProvider.instance;

    ListEvolucao novoComentario = ListEvolucao(
      comentario: comentarioController.text,
      nome: pacienteProvider.paciente!.dadosPacienteModel.nome,
      dataCriancao: Timestamp.now(),
    );
    showModalBottomSheet(
      backgroundColor: background,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Adicionar evolução",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: comentarioController,
              decoration: const InputDecoration(
                labelText: "Digite a evolução do paciente",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Botaoprincipal(
              text: 'Salvar Evolução',
              carregando: _carregando,
              onPressed: () async {
                if (_carregando) return;
                try {
                  if (comentarioController.text.isEmpty) {
                    snackAtencao(context, "Digite um comentário para salvar");
                    return;
                  }
                  setState(() {
                    _carregando = true;
                  });
                  evolucao ??= EvolucaoModel(evolucoesModel: []);

                  novoComentario.dataCriancao = Timestamp.now();
                  novoComentario.comentario = comentarioController.text;
                  novoComentario.nome = profissionalProvider.profissional?.nome;

                  evolucao?.evolucoesModel?.add(novoComentario);

                  await GerenciaPacienteRepository()
                      .cadastraEvolucao(evolucao!, pacienteProvider.paciente!.dadosPacienteModel.uidDocumento);

                  pacienteProvider.setUpdateEvolucao(novoComentario);

                  snackSucesso(context, "Comentário salvo com sucesso");
                  Navigator.of(context).pop();
                  setState(() {
                    _carregando = false;
                  });
                  comentarioController.text = '';
                } catch (e) {
                  setState(() {
                    _carregando = false;
                  });
                  print(e);
                  comentarioController.text = '';

                  snackErro(context, "Erro ao salvar comentário");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  int _comentariosCount(DateTime day, EvolucaoModel? evolucaoModel) {
    if (evolucaoModel == null) return 0;
    return evolucaoModel.evolucoesModel?.where((e) => isSameDay(e.dataCriancao?.toDate(), day)).length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Evolução do Paciente",
          style: TextStyle(color: Colors.green[900]),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green[900]),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<PacienteProvider>(
          builder: (context, value, child) {
            final pacienteProvider = value.paciente;
            final evolucaoModel = pacienteProvider?.evolucoesModel;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ClipOval(
                      child: pacienteProvider!.dadosPacienteModel.urlFoto != ''
                          ? Image.network(
                              pacienteProvider.dadosPacienteModel.urlFoto,
                              width: 78,
                              height: 78,
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.person,
                              size: 78,
                              color: Colors.grey,
                            ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      pacienteProvider.dadosPacienteModel.nome,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      pacienteProvider.dadosPacienteModel.outrasInformacoes.observacao ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TableCalendar(
                  locale: 'pt_BR',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: selectedDate,
                  calendarFormat: calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                    });
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Mês',
                    CalendarFormat.twoWeeks: '2 Semanas',
                    CalendarFormat.week: 'Semana',
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: verde2,
                      shape: BoxShape.circle,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      int count = _comentariosCount(date, evolucaoModel);
                      if (count > 0) {
                        return Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: bege,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              '$count',
                              style: const TextStyle(color: Colors.black87, fontSize: 12),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                    selectedBuilder: (context, date, _) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.green[900],
                          shape: BoxShape.circle,
                        ),
                        margin: const EdgeInsets.all(6.0),
                        alignment: Alignment.center,
                        child: Text(
                          '${date.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    defaultBuilder: (context, date, _) {
                      int count = _comentariosCount(date, evolucaoModel);
                      return Container(
                        margin: const EdgeInsets.all(6.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: count > 0 ? Colors.green[300] : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: count > 0 ? Colors.black : Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Evolução para ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final evolucoesFiltradas = evolucaoModel?.evolucoesModel
                          ?.where((e) => isSameDay(e.dataCriancao?.toDate(), selectedDate))
                          .toList();

                      if (evolucoesFiltradas == null || evolucoesFiltradas.isEmpty) {
                        return const Center(
                          child: Text(
                            "Nenhuma evolução encontrada",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      evolucoesFiltradas.sort((a, b) => b.dataCriancao!.compareTo(a.dataCriancao!));

                      return ListView.builder(
                        itemCount: evolucoesFiltradas.length,
                        itemBuilder: (context, index) {
                          final evolucao = evolucoesFiltradas[index];
                          return ListTile(
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                try {
                                  setState(() {
                                    evolucaoModel?.evolucoesModel?.remove(evolucao);
                                  });
                                  await GerenciaPacienteRepository().cadastraEvolucao(
                                      evolucaoModel!, pacienteProvider.dadosPacienteModel.uidDocumento);
                                  snackSucesso(context, "Comentário excluído com sucesso");
                                } catch (e) {
                                  snackErro(context, "Erro ao excluir comentário");
                                }
                              },
                            ),
                            title: Text(evolucao.nome ?? "Nome não disponível"),
                            subtitle: Text(evolucao.comentario ?? "Comentário não disponível"),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _adicionarComentario(),
        backgroundColor: Colors.green[900],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
