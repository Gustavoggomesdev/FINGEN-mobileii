import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../colors/app_colors.dart';
import '../../typography/app_typography.dart';
import '../../spacing/app_spacing.dart';
import 'investment_card_view_model.dart';

class InvestmentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String percentage;
  final Color? accentColor;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final bool hasInvestment;

  const InvestmentCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.percentage,
    this.accentColor,
    this.onAdd,
    this.onRemove,
    this.hasInvestment = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InvestmentCardViewModel(),
      child: Consumer<InvestmentCardViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (accentColor != null)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: accentColor!.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: accentColor,
                            size: 20,
                          ),
                        ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppTypography.labelLarge,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              subtitle,
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        child: Text(
                          percentage,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Investido',
                            style: AppTypography.labelSmall,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            amount,
                            style: AppTypography.h4,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (hasInvestment && onRemove != null)
                            IconButton(
                              onPressed: onRemove,
                              icon: const Icon(Icons.remove_circle_outline),
                              color: AppColors.error,
                              iconSize: 28,
                            ),
                          if (onAdd != null)
                            IconButton(
                              onPressed: onAdd,
                              icon: const Icon(Icons.add_circle),
                              color: AppColors.success,
                              iconSize: 28,
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}