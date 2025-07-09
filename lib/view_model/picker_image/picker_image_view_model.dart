import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickerImageViewModel extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];

  List<XFile> get images => _images;
  // This class will handle the logic for picking images
  // You can add methods to pick images, handle errors, etc.

  // Example method to pick an imag
  Future<void> pickImageFromGallery() async {
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage(
        imageQuality: 50, // Optional: Set image quality
      );
      if (pickedFiles != null) {
        _images.addAll(pickedFiles);
        notifyListeners(); // Notify listeners to update the UI
      }
    } catch (e) {
      // Handle any errors that occur during image picking
      print('Error picking images: $e');
    }
  }
}
