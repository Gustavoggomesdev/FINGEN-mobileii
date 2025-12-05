import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../colors/app_colors.dart';
import '../../typography/app_typography.dart';
import '../../spacing/app_spacing.dart';
import 'custom_tab_bar_view_model.dart';

class TabItem {
  final String label;
  final IconData icon;

  TabItem({
    required this.label,
    required this.icon,
  });
}

class CustomTabBar extends StatelessWidget {
  final List<TabItem> tabs;
  final Function(int) onTabChanged;
  final CustomTabBarViewModel? viewModel;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel ?? CustomTabBarViewModel(),
      child: Consumer<CustomTabBarViewModel>(
        builder: (context, vm, _) {
          return Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                top: BorderSide(color: AppColors.border, width: 1),
              ),
            ),
            child: Row(
              children: List.generate(tabs.length, (index) {
                final tab = tabs[index];
                final isSelected = vm.currentIndex == index;

                return Expanded(
                  child: InkWell(
                    onTap: () {
                      vm.changeTab(index);
                      onTabChanged(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            tab.icon,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textTertiary,
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tab.label,
                            style: AppTypography.labelSmall.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textTertiary,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}