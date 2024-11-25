import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/botaoPrincipal.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MaterialApp(
    home: EvolucaoPacientePage(),
    locale: Locale('pt', 'BR'),
    supportedLocales: [Locale('pt', 'BR'), Locale('en', 'US')],
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
  ));
}

class EvolucaoPacientePage extends StatefulWidget {
  const EvolucaoPacientePage({super.key});

  @override
  _EvolucaoPacientePageState createState() => _EvolucaoPacientePageState();
}

class _EvolucaoPacientePageState extends State<EvolucaoPacientePage> {
  DateTime selectedDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.week;
  TextEditingController comentarioController = TextEditingController();
  Map<DateTime, List<String>> comentarios = {};

  void _adicionarComentario() {
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
              "Adicionar comentário",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: comentarioController,
              decoration: const InputDecoration(
                labelText: "Digite o comentário",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Botaoprincipal(
              text: 'Salvar Comentário',
              onPressed: () {
                setState(() {
                  if (comentarioController.text.isNotEmpty) {
                    comentarios[selectedDate] ??= [];
                    comentarios[selectedDate]!.add(comentarioController.text);
                    comentarioController.clear();
                    Navigator.pop(context); // Fecha o BottomSheet
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  int _comentariosCount(DateTime day) {
    return comentarios[day]?.length ?? 0;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/paciente.jpg'),
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Fernanda da Silva",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "20 anos, depressão e ansiedade",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
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
                  int count = _comentariosCount(date);
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
                  int count = _comentariosCount(date);
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
            if (comentarios[selectedDate]?.isNotEmpty ?? false)
              Expanded(
                child: ListView.builder(
                  itemCount: comentarios[selectedDate]?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/psicologo.jpg'),
                      ),
                      title: const Text("Dr. Júlia Lorem Ipsum"),
                      subtitle: Text(comentarios[selectedDate]![index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarComentario,
        backgroundColor: Colors.green[900],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
