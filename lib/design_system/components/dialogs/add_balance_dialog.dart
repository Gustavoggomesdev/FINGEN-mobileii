import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../colors/app_colors.dart';
import '../../typography/app_typography.dart';
import '../../spacing/app_spacing.dart';
import '../buttons/button.dart';
import '../inputs/amount_input.dart';
import 'add_balance_dialog_view_model.dart';

class AddBalanceDialog extends StatelessWidget {
  final String title;
  final double maxAmount;
  final Function(double) onConfirm;

  const AddBalanceDialog({
    super.key,
    required this.title,
    required this.maxAmount,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddBalanceDialogViewModel(
        maxAmount: maxAmount,
        onConfirm: onConfirm,
      ),
      child: Consumer<AddBalanceDialogViewModel>(
        builder: (context, viewModel, _) {
          return Dialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.h3,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AmountInput(
                      label: 'Valor',
                      controller: viewModel.amountController,
                      hint: 'Digite o valor',
                      validator: viewModel.validateAmount,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Disponível: R\$ ${maxAmount.toStringAsFixed(2)}',
                      style: AppTypography.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'Cancelar',
                            type: ButtonType.secondary,
                            onPressed: viewModel.isProcessing
                                ? null
                                : () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: AppButton(
                            text: 'Confirmar',
                            type: ButtonType.primary,
                            isLoading: viewModel.isProcessing,
                            onPressed: () => viewModel.confirm(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}