import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../design_system/colors/app_colors.dart';
import '../../design_system/typography/app_typography.dart';
import '../../design_system/spacing/app_spacing.dart';
import '../../design_system/components/buttons/button.dart';
import '../../design_system/components/inputs/custom_text_field.dart';
import '../../design_system/components/dialogs/confirm_dialog.dart';
import 'settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<SettingsViewModel>(
          builder: (context, viewModel, _) {
            return CustomScrollView(
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
                          'Configurações',
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
                        // ======== SEÇÃO: PERFIL DO USUÁRIO ========
                        Text('Perfil', style: AppTypography.h3),
                        const SizedBox(height: AppSpacing.lg),
                        
                        // Card com Avatar e Dados do Usuário
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      viewModel.currentUser?.name ?? '',
                                      style: AppTypography.h4,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      viewModel.currentUser?.email ?? '',
                                      style: AppTypography.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // ======== SEÇÃO: EDITAR INFORMAÇÕES DA CONTA ========
                        Text('Informações da Conta', style: AppTypography.h3),
                        const SizedBox(height: AppSpacing.lg),

                        // Input de Nome
                        CustomTextField(
                          label: 'Nome de Usuário',
                          controller: viewModel.nameController,
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Botão para Salvar Alterações
                        AppButton(
                          text: 'Salvar Alterações',
                          type: ButtonType.primary,
                          onPressed: viewModel.updateName,
                          icon: Icons.save,
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // ======== SEÇÃO: CONFIGURAÇÕES GERAIS ========
                        Text('Geral', style: AppTypography.h3),
                        const SizedBox(height: AppSpacing.lg),

                        // Items de Configuração
                        _buildSettingItem(
                          context,
                          icon: Icons.notifications_outlined,
                          title: 'Notificações',
                          subtitle: 'Gerencie suas notificações',
                          onTap: () {},
                        ),
                        _buildSettingItem(
                          context,
                          icon: Icons.security_outlined,
                          title: 'Privacidade e Segurança',
                          subtitle: 'Controle suas configurações de privacidade',
                          onTap: () {},
                        ),
                        _buildSettingItem(
                          context,
                          icon: Icons.language_outlined,
                          title: 'Idioma',
                          subtitle: 'Português (Brasil)',
                          onTap: () {},
                        ),
                        _buildSettingItem(
                          context,
                          icon: Icons.dark_mode_outlined,
                          title: 'Tema',
                          subtitle: 'Claro',
                          onTap: () {},
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // ======== SEÇÃO: SUPORTE ========
                        Text('Suporte', style: AppTypography.h3),
                        const SizedBox(height: AppSpacing.lg),

                        // Items de Suporte
                        _buildSettingItem(
                          context,
                          icon: Icons.help_outline,
                          title: 'Central de Ajuda',
                          subtitle: 'Obtenha ajuda e suporte',
                          onTap: () {},
                        ),
                        _buildSettingItem(
                          context,
                          icon: Icons.info_outline,
                          title: 'Sobre',
                          subtitle: 'Versão 1.0.0',
                          onTap: () {},
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // ======== BOTÃO: LOGOUT COM CONFIRMAÇÃO ========
                        AppButton(
                          text: 'Sair',
                          type: ButtonType.primary,
                          icon: Icons.logout,
                          onPressed: () {
                            // Dialog de Confirmação Antes de Sair
                            showDialog(
                              context: context,
                              builder: (ctx) => ConfirmDialog(
                                title: 'Sair da conta',
                                message: 'Tem certeza que deseja sair?',
                                confirmText: 'Sair',
                                isDangerous: true,
                                onConfirm: viewModel.logout,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
      child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(title, style: AppTypography.labelLarge),
      subtitle: Text(subtitle, style: AppTypography.bodySmall),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textTertiary),
      onTap: onTap,
      ),
      );
      }
      }