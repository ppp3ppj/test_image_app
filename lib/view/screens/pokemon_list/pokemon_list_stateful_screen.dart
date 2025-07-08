import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonListStatefulScreen extends StatefulWidget {
  const PokemonListStatefulScreen({super.key});

  @override
  State<PokemonListStatefulScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListStatefulScreen> {
  List<dynamic> pokemonList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    //fetchPokemonList(10);
  }

  Future<void> fetchPokemonList(int limit) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=$limit'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        pokemonList = data['results'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  String getPokemonImageUrl(int index) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('[Stateful] Pokemon List')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Limit pokemon',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    final limit = int.tryParse(value.toString());
                    if (limit != null && limit > 0) {
                      setState(() {
                        isLoading = true;
                      });
                      fetchPokemonList(limit);
                    }
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: pokemonList.length,
                    itemBuilder: (context, index) {
                      final pokemon = pokemonList[index];
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              getPokemonImageUrl(index),
                              width: 48,
                              height: 48,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    pokemon['name'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to Home Screen'),
                ),
              ],
            ),
    );
  }
}
