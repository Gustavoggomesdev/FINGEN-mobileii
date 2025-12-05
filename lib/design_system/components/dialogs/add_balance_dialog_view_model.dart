import 'package:flutter/material.dart';

class AddBalanceDialogViewModel extends ChangeNotifier {
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final double maxAmount;
  final Function(double) onConfirm;

  AddBalanceDialogViewModel({
    required this.maxAmount,
    required this.onConfirm,
  });

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite um valor';
    }
    final amount = double.tryParse(value.replaceAll(',', '.'));
    if (amount == null || amount <= 0) {
      return 'Digite um valor válido';
    }
    if (amount > maxAmount) {
      return 'Saldo insuficiente';
    }
    return null;
  }

  Future<void> confirm(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    _isProcessing = true;
    notifyListeners();

    final amount = double.parse(
      amountController.text.replaceAll(',', '.'),
    );

    await Future.delayed(const Duration(milliseconds: 300));

    _isProcessing = false;
    notifyListeners();

    onConfirm(amount);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}