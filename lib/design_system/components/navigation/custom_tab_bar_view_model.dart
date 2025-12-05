import 'package:flutter/material.dart';

class CustomTabBarViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeTab(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void reset() {
    _currentIndex = 0;
    notifyListeners();
  }
}