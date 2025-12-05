import 'package:flutter/material.dart';

class CustomTextFieldViewModel extends ChangeNotifier {
  bool _isFocused = false;
  bool get isFocused => _isFocused;

  String _errorText = '';
  String get errorText => _errorText;

  void setFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  void setError(String error) {
    _errorText = error;
    notifyListeners();
  }

  void clearError() {
    _errorText = '';
    notifyListeners();
  }
}