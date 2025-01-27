import 'package:flutter/material.dart';
import 'package:reabilita_social/repository/profissional/registro_produtividade_repository.dart';
import 'package:reabilita_social/screens/profissional/produtividade_lista.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';
import 'package:intl/intl.dart';

class RegistroProdutividade extends StatefulWidget {
  @override
  _RegistroProdutividadeState createState() => _RegistroProdutividadeState();
}

class _RegistroProdutividadeState extends State<RegistroProdutividade> {
  String? _selectedOption;
  String? _selectedSubtitle;
  DateTime? _selectedDateTime;
  String? _formattedDateTime;

  final List<Map<String, String>> _op = op;
  List<Map<String, dynamic>> _userRecords = [];

  final RegistroProdutividadeRepository _firebaseQueries =
      RegistroProdutividadeRepository();

  @override
  void initState() {
    super.initState();
    _loadUserRecords();
  }

  Future<void> _loadUserRecords() async {
    final records = await _firebaseQueries.getUserRecords();
    setState(() {
      _userRecords = records;
    });
  }

  Future<void> _deleteRecord(String recordId) async {
    try {
      await _firebaseQueries.deleteUserRecord(recordId);
      await _loadUserRecords();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro excluído com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir o registro: $e')),
      );
    }
  }

  Future<void> _saveRecord() async {
    if (_selectedOption == null ||
        _selectedSubtitle == null ||
        _formattedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecione uma opção primeiro.')),
      );
      return;
    }

    final record = {
      "procedimento": _selectedOption!,
      "descricao": _selectedSubtitle!,
      "dataHora": _formattedDateTime!,
    };

    await _firebaseQueries.saveUserRecord(record);
    await _loadUserRecords();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registro salvo com sucesso!')),
    );
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Produtividade'),
        backgroundColor: background,
      ),
      body: Container(
        color: background,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            PopupMenuButton<String>(
              onSelected: (String selected) {
                setState(() {
                  _selectedOption = selected;
                  _selectedSubtitle = _op.firstWhere(
                      (option) => option['title'] == selected)['subtitle'];
                  _selectedDateTime = DateTime.now();
                  _formattedDateTime = _formatDate(_selectedDateTime!);
                });
              },
              itemBuilder: (BuildContext context) {
                return _op
                    .map<PopupMenuEntry<String>>((Map<String, String> option) {
                  return PopupMenuItem<String>(
                    value: option['title']!,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Text('${option['title']} - ${option['subtitle']}'),
                    ),
                  );
                }).toList();
              },
              color: background, // Cor de fundo do dropdown
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_drop_down),
                    Flexible(
                      child: Text(
                        _selectedOption != null && _selectedSubtitle != null
                            ? '$_selectedOption - $_selectedSubtitle' // Mostra título e subtítulo
                            : 'Selecione uma opção', // Texto padrão
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow
                            .ellipsis, // Caso o texto fique muito longo
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Botaoprincipal(
                text: 'Salvar novo registro', onPressed: _saveRecord),
            const SizedBox(height: 30),
            const Text(
              'Seus Registros:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
                child: _userRecords.isEmpty
                    ? Center(
                        child: Text(
                          'Nenhum registro salvo.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _userRecords.length,
                        itemBuilder: (context, index) {
                          final record = _userRecords[index];
                          return _buildRecordCard(
                            record['procedimento'],
                            record['descricao'],
                            record['dataHora'],
                            record['id'],
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(
      String procedimento, String descricao, String dataHora, String recordId) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Procedimento: $procedimento',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Descrição: $descricao',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Data e Hora: $dataHora',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.grey),
                onPressed: () async {
                  await _deleteRecord(recordId);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
