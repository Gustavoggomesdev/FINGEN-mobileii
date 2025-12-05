import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../design_system/colors/app_colors.dart';
import '../../design_system/typography/app_typography.dart';
import '../../design_system/spacing/app_spacing.dart';
import '../../design_system/components/buttons/button.dart';
import '../../design_system/components/cards/summary_card.dart';
import '../../design_system/components/loading/loading_indicator.dart';
import '../../design_system/components/dialogs/add_balance_dialog.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  String _formatCurrency(double value) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const LoadingIndicator();
            }

            final user = viewModel.currentUser;
            if (user == null) return const SizedBox();

            return RefreshIndicator(
              onRefresh: viewModel.refreshBalances,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 120,
                    floating: false,
                    pinned: true,
                    backgroundColor: AppColors.surface,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      titlePadding: const EdgeInsets.only(
                        left: AppSpacing.lg,
                        bottom: AppSpacing.md,
                      ),
                      title: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá',
                              style: AppTypography.labelSmall.copyWith(fontSize: 14),  
                            ),
                            Text(
                              '${user.name}',
                              style: AppTypography.h3.copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ======== CARD DE SALDO TOTAL COM GRADIENTE ========
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, AppColors.primaryDark],
                              ),
                              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Saldo Total',
                                      style: AppTypography.labelMedium.copyWith(
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                    if (viewModel.isRefreshing)
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  _formatCurrency(user.totalBalance),
                                  style: AppTypography.h1.copyWith(
                                    color: Colors.white,
                                    fontSize: 36,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          // ======== BOTÕES: ADICIONAR E REMOVER SALDO ========
                          Row(
                            children: [
                              // Botão Adicionar
                              Expanded(
                                child: AppButton(
                                  text: 'Adicionar',
                                  type: ButtonType.primary,
                                  icon: Icons.add,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AddBalanceDialog(
                                        title: 'Adicionar Saldo',
                                        maxAmount: double.infinity,
                                        onConfirm: (amount) {
                                          viewModel.addBalance(amount);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              // Botão Remover
                              Expanded(
                                child: AppButton(
                                  text: 'Remover',
                                  type: ButtonType.secondary,
                                  icon: Icons.remove,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AddBalanceDialog(
                                        title: 'Remover Saldo',
                                        maxAmount: user.totalBalance,
                                        onConfirm: (amount) {
                                          viewModel.removeBalance(amount);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // ======== SEÇÃO: RESUMO DE INVESTIMENTOS ========
                          Text('Resumo de Investimentos', style: AppTypography.h3),
                          const SizedBox(height: AppSpacing.md),

                          // ======== ESTADO VAZIO: NENHUM INVESTIMENTO ========
                          if (viewModel.investments.isEmpty)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(AppSpacing.xl),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceVariant,
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 60,
                                    color: AppColors.textTertiary,
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  Text(
                                    'Nenhum investimento ainda',
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    'Acesse a aba Investimentos para começar',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.textTertiary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          // ======== LISTAGEM DE INVESTIMENTOS ========
                          else
                            Column(
                              children: [
                                // Card de Total Investido
                                SummaryCard(
                                  title: 'Total Investido',
                                  value: _formatCurrency(viewModel.totalInvested),
                                  icon: Icons.trending_up,
                                  color: AppColors.success,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                
                                // ======== CARDS INDIVIDUAIS DE CADA INVESTIMENTO ========
                                ...viewModel.investments.map((investment) {
                                  final currentValue = investment.getCurrentValue();
                                  final profitLoss = currentValue - investment.amount;
                                  final isProfit = profitLoss >= 0;
                                  final isCrypto = investment.type.toString() == 'InvestmentType.crypto';

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                                    padding: const EdgeInsets.all(AppSpacing.md),
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                      border: Border.all(color: AppColors.border),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                investment.name,
                                                style: AppTypography.labelLarge,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Investido: ${_formatCurrency(investment.amount)}',
                                                style: AppTypography.bodySmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              _formatCurrency(currentValue),
                                              style: AppTypography.labelLarge.copyWith(
                                                color: isProfit
                                                    ? AppColors.success
                                                    : AppColors.error,
                                              ),
                                            ),
                                            Text(
                                              '${isProfit ? '+' : ''}${(profitLoss / investment.amount * 100).toStringAsFixed(1)}%',
                                              style: AppTypography.bodySmall.copyWith(
                                                color: isProfit
                                                    ? AppColors.success
                                                    : AppColors.error,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              isCrypto ? 'Preço atual' : 'Projeção em 1 ano',
                                              style: AppTypography.bodySmall.copyWith(
                                                color: AppColors.textTertiary,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          const SizedBox(height: AppSpacing.xxl),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}