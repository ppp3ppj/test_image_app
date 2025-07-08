import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_image_app/view_model/pokemon_list/pokemon_list_view_model.dart';

class PokemonListStatelessScreen extends StatelessWidget {
  const PokemonListStatelessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PokemonListViewModel>(context);

    viewModel.isLoading = false;

    return Scaffold(
      appBar: AppBar(title: const Text('[Stateless] Pokemon List')),
      body: viewModel.isLoading
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
                      viewModel.isLoading = true;
                      viewModel.fetchPokemonList(limit);
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
                    itemCount: viewModel.pokemonList.length,
                    itemBuilder: (context, index) {
                      final pokemon = viewModel.pokemonList[index];
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              viewModel.getPokemonImageUrl(index),
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
