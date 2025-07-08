import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonListViewModel extends ChangeNotifier {
  List<dynamic> pokemonList = [];
  bool isLoading = true;

  Future<void> fetchPokemonList(int limit) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=$limit'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        pokemonList = data['results'];
      } else {
        throw Exception('Failed to load Pokemon list');
      }
    } catch (e) {
      print('Error fetching Pokemon list: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String getPokemonImageUrl(int index) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png';
  }
}
