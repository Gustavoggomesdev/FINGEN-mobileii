import 'package:flutter/material.dart';

class SummaryCardViewModel extends ChangeNotifier {
  bool _isHovered = false;
  bool get isHovered => _isHovered;

  void setHovered(bool value) {
    _isHovered = value;
    notifyListeners();
  }
}