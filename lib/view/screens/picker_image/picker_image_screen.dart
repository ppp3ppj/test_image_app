import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_image_app/view_model/picker_image/picker_image_view_model.dart';

class PickerImageScreen extends StatelessWidget {
  const PickerImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PickerImageViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Upload Image')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                viewModel.pickImageFromGallery();
              },
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: viewModel.images.isEmpty
                  ? const Text('No images selected.')
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: viewModel.images.length,
                      itemBuilder: (context, index) {
                        final image = viewModel.images[index];
                        return Image.file(
                          File(image.path),
                          fit: BoxFit.cover,
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
