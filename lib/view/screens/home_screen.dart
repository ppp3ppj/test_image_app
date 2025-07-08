import 'package:flutter/material.dart';
import 'package:test_image_app/view_model/counter_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterVM = Provider.of<CounterViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Demo Test Image App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter Value:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text(
              '${counterVM.counter}',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: counterVM.incrementCounter,
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: counterVM.decrementCounter,
                  child: Icon(Icons.remove),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () => {Navigator.pushNamed(context, '/counter_add2')},
              child: const Text('Sample ViewModel'),
            ),
            ElevatedButton(
              onPressed: () => {Navigator.pushNamed(context, '/pokemon_list_steteful')},
              child: const Text('Stateful Performance Demo'),
            ),
            ElevatedButton(
              onPressed: () => {Navigator.pushNamed(context, '/pokemon_list_stateless')},
              child: const Text('Stateless Performance Demo'),
            ),
          ],
        ),
      ),
    );
  }
}
