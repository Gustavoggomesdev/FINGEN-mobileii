// lib/scenes/login/login_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../design_system/colors/app_colors.dart';
import '../../design_system/typography/app_typography.dart';
import '../../design_system/spacing/app_spacing.dart';
import '../../design_system/components/buttons/button.dart';
import '../../design_system/components/inputs/custom_text_field.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LoginViewModel>(
          builder: (context, viewModel, _) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ======== HEADER COM ÍCONE ========
                  const Icon(
                    Icons.account_balance_wallet,
                    size: 80,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  
                  // ======== TÍTULO PRINCIPAL ========
                  Text(
                    'Gerenciador de\nInvestimentos',
                    style: AppTypography.h1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  
                  // ======== SUBTÍTULO ========
                  Text(
                    'Faça login para continuar',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  
                  // ======== CAMPO DE EMAIL ========
                  CustomTextField(
                    label: 'Email',
                    hint: 'seu@email.com',
                    controller: viewModel.emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  
                  // ======== CAMPO DE SENHA COM TOGGLE ========
                  CustomTextField(
                    label: 'Senha',
                    hint: '••••••',
                    controller: viewModel.passwordController,
                    obscureText: viewModel.obscurePassword,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewModel.obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: viewModel.togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  
                  // ======== BOTÃO DE LOGIN ========
                  AppButton(
                    text: 'Entrar',
                    type: ButtonType.primary,
                    onPressed: viewModel.login,
                    isLoading: viewModel.isLoading,
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