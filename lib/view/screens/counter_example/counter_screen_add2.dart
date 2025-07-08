import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_image_app/view_model/counter_example/counter_add2_view_model.dart';

class CounterScreenAdd2 extends StatelessWidget {
  const CounterScreenAdd2({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CounterAdd2ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter View Add2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Add2 Count', style: TextStyle(fontSize: 24)),
            Text('${vm.count}', style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: vm.minus, child: const Text('-5')),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: vm.plus, child: const Text('+5')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}