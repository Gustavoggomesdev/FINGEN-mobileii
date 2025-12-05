import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../design_system/colors/app_colors.dart';
import '../../design_system/typography/app_typography.dart';
import '../../design_system/spacing/app_spacing.dart';
import '../../design_system/components/cards/investment_card.dart';
import '../../design_system/components/loading/loading_indicator.dart';
import '../../design_system/components/dialogs/add_balance_dialog.dart';
import 'investments_view_model.dart';

class InvestmentsView extends StatelessWidget {
  const InvestmentsView({super.key});

  String _formatCurrency(double value) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<InvestmentsViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const LoadingIndicator();
            }

            return RefreshIndicator(
              onRefresh: viewModel.refresh,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 120,
                    floating: false,
                    pinned: true,
                    backgroundColor: AppColors.surface,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.only(
                        left: AppSpacing.lg,
                        bottom: AppSpacing.md,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Investimentos',
                            style: AppTypography.h3.copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ======== CARD DE SALDO DISPONÍVEL ========
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Saldo Disponível',
                                  style: AppTypography.labelMedium,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  _formatCurrency(viewModel.availableBalance),
                                  style: AppTypography.h2.copyWith(
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // ======== SEÇÃO: RENDA FIXA - BANCOS ========
                          Text('Renda Fixa - CDB', style: AppTypography.h3),
                          const SizedBox(height: AppSpacing.md),
                          
                          // ======== LISTAGEM DE CARDS DE BANCOS ========
                          ...viewModel.banks.map((bank) {
                            return InvestmentCard(
                              title: bank.bankName,
                              subtitle: bank.name,
                              amount: _formatCurrency(bank.amount),
                              percentage: '${bank.cdiPercentage.toStringAsFixed(0)}% CDI',
                              accentColor: AppColors.primary,
                              hasInvestment: bank.amount > 0,
                              onAdd: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AddBalanceDialog(
                                    title: 'Investir em ${bank.bankName}',
                                    maxAmount: viewModel.availableBalance,
                                    onConfirm: (amount) {
                                      viewModel.addInvestment(bank.id, amount, false);
                                    },
                                  ),
                                );
                              },
                              onRemove: bank.amount > 0
                                  ? () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AddBalanceDialog(
                                          title: 'Remover de ${bank.bankName}',
                                          maxAmount: bank.amount,
                                          onConfirm: (amount) {
                                            viewModel.removeInvestment(bank.id, amount);
                                          },
                                        ),
                                      );
                                    }
                                  : null,
                            );
                          }).toList(),

                          const SizedBox(height: AppSpacing.xl),

                          // ======== SEÇÃO: CRIPTOMOEDAS ========
                          Text('Criptomoedas', style: AppTypography.h3),
                          const SizedBox(height: AppSpacing.md),
                          
                          // ======== LISTAGEM DE CARDS DE CRYPTOS ========
                          ...viewModel.cryptos.map((crypto) {
                            Color cryptoColor = AppColors.bitcoin;
                            if (crypto.symbol == 'ETH') {
                              cryptoColor = AppColors.ethereum;
                            } else if (crypto.symbol == 'BNB') {
                              cryptoColor = AppColors.binance;
                            }

                            return InvestmentCard(
                              title: crypto.name,
                              subtitle: crypto.symbol,
                              amount: _formatCurrency(
                                crypto.amount > 0 ? crypto.getCurrentValue() : 0,
                              ),
                              percentage: _formatCurrency(crypto.currentPrice),
                              accentColor: cryptoColor,
                              hasInvestment: crypto.amount > 0,
                              onAdd: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AddBalanceDialog(
                                    title: 'Investir em ${crypto.name}',
                                    maxAmount: viewModel.availableBalance,
                                    onConfirm: (amount) {
                                      viewModel.addInvestment(crypto.id, amount, true);
                                    },
                                  ),
                                );
                              },
                              onRemove: crypto.amount > 0
                                  ? () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AddBalanceDialog(
                                          title: 'Remover de ${crypto.name}',
                                          maxAmount: crypto.amount,
                                          onConfirm: (amount) {
                                            viewModel.removeInvestment(crypto.id, amount);
                                          },
                                        ),
                                      );
                                    }
                                  : null,
                            );
                          }).toList(),
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