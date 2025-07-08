import 'package:flutter/material.dart';

class CounterAdd2ViewModel extends ChangeNotifier {
  int _count = 100;

  int get count => _count;

  void plus() {
    _count += 5;
    notifyListeners();
  }

  void minus() {
    _count -= 5;
    notifyListeners();
  }
}