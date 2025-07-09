import 'package:flutter/material.dart';
import 'package:test_image_app/view_model/counter_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo Test Image App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => {Navigator.pushNamed(context, '/counter_add2')},
              child: const Text('Sample ViewModel'),
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.pushNamed(context, '/pokemon_list_steteful'),
              },
              child: const Text('Stateful Performance Demo'),
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.pushNamed(context, '/pokemon_list_stateless'),
              },
              child: const Text('Stateless Performance Demo'),
            ),
            ElevatedButton(
              onPressed: () => {Navigator.pushNamed(context, '/picker_image')},
              child: const Text('Image Picker Demo'),
            ),
          ],
        ),
      ),
    );
  }
}
