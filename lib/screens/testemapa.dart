import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _places = [];

  Future<Map<String, dynamic>> getCoordinates(String address) async {
    const apiKey = 'AIzaSyAoSesmAI2cUK5YF4PWUXJOc_TjhdhA7o4'; // Substitua pela sua chave de API
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        final location = data['results'][0]['geometry']['location'];
        return {'lat': location['lat'], 'lng': location['lng']};
      }
    }
    throw Exception('Failed to get coordinates');
  }

  Future<List<dynamic>> getNearbyPlaces(double lat, double lng) async {
    const apiKey = 'AIzaSyAoSesmAI2cUK5YF4PWUXJOc_TjhdhA7o4'; // Substitua pela sua chave de API
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=1500&type=health&keyword=mental&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    }
    throw Exception('Failed to get nearby places');
  }

  void _search() async {
    final address = _controller.text;
    final coordinates = await getCoordinates(address);
    final places = await getNearbyPlaces(coordinates['lat'], coordinates['lng']);
    setState(() {
      _places = places;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Mental Health Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter address',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  final place = _places[index];
                  return ListTile(
                    title: Text(place['name']),
                    subtitle: Text(place['vicinity']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
