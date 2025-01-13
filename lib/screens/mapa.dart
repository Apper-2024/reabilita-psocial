import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reabilita_social/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _places = [];
  List<String> _suggestions = [];
  bool _isLoading = false;

  Future<List<dynamic>> searchNearbyPlaces(String address) async {
    final url =
        'https://us-central1-reabilitapsocial.cloudfunctions.net/searchNearbyPlaces/searchNearbyPlaces?address=$address';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    }
    throw Exception('Erro ao buscar os recursos de ajuda!');
  }

  Future<List<String>> fetchCities(String query) async {
    if (query.isEmpty) return [];

    const url =
        'https://servicodados.ibge.gov.br/api/v1/localidades/municipios';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> cities = json.decode(response.body);
      return cities
          .map((city) => city['nome'] as String)
          .where((name) => name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    } else {
      throw Exception('Erro ao buscar cidades');
    }
  }

  void _search() async {
    final address = _controller.text;
    if (address.isEmpty) return;

    setState(() {
      _isLoading = true;
      _places = [];
    });

    try {
      final places = await searchNearbyPlaces(address);
      setState(() {
        _places = places;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao buscar lugares')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onQueryChanged(String query) async {
    try {
      final suggestions = await fetchCities(query);
      setState(() {
        _suggestions = suggestions;
      });
    } catch (e) {
      setState(() {
        _suggestions = [];
      });
    }
  }

  void _openMap(String placeName) async {
    final url = Uri.encodeFull(
        'https://www.google.com/maps/search/?api=1&query=$placeName');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception('Não foi possível abrir o mapa');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Busca Psicosocial',
          style: TextStyle(color: preto1),
        ),
        centerTitle: true,
        backgroundColor: background,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchField(),
            const SizedBox(height: 10),
            if (_suggestions.isNotEmpty) _buildSuggestionsList(),
            const SizedBox(height: 10),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_places.isEmpty)
              const Text(
                'Digite o endereço para encontrar ajuda psicosocial!',
                style: TextStyle(color: Colors.grey),
              )
            else
              Expanded(child: _buildPlacesList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _controller,
      onChanged: _onQueryChanged,
      decoration: InputDecoration(
        labelText: 'Endereço',
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          color: Colors.black,
          onPressed: _search,
        ),
      ),
    );
  }

  Widget _buildSuggestionsList() {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListView.builder(
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_suggestions[index]),
            onTap: () {
              _controller.text = _suggestions[index];
              _suggestions.clear();
              _search();
            },
          );
        },
      ),
    );
  }

  Widget _buildPlacesList() {
    return ListView.builder(
      itemCount: _places.length,
      itemBuilder: (context, index) {
        final place = _places[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Colors.white70,
                width: 1.5,
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place['name'] ?? 'Nome desconhecido',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        place['vicinity'] ?? 'Endereço desconhecido',
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.teal),
                    onPressed: () => _openMap(place['name'] ?? ''),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
