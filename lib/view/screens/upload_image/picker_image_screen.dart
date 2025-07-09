import 'package:flutter/material.dart';

  class PickerImageScreen extends StatelessWidget {
  const PickerImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Implement image upload functionality here
          },
          child: const Text('Upload Image'),
        ),
      ),
    );
  }
}