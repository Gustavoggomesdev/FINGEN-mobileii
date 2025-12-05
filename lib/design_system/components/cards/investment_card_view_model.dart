import 'package:flutter/material.dart';

class InvestmentCardViewModel extends ChangeNotifier {
  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}