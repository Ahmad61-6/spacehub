import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/view/screens/auth/login_screen.dart';
import 'package:spacehub/view/utility/app_colors.dart';

import '../../../../controllers/auth/auth_controller.dart';

class PasswordRecoveryConfirmationScreen extends StatelessWidget {
  final String email;

  const PasswordRecoveryConfirmationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    Colors.grey.shade900,
                    Colors.grey.shade800,
                    Colors.grey.shade700,
                  ]
                : [
                    Colors.blue.shade50,
                    Colors.blue.shade100,
                    Colors.blue.shade200,
                  ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.mark_email_read_outlined,
                        size: 100,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Check Your Email',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'We\'ve sent a password recovery link to:',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: textColor.withValues(alpha: 0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'This link will expire in 24 hours. If you don\'t see the email, check your spam folder.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: textColor.withOpacity(0.6),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: theme.colorScheme.primary,
                          ),
                          onPressed: () {
                            Get.offAll(() =>
                                LoginScreen()); // Clear all and go to login
                          },
                          child: const Text(
                            'RETURN TO LOGIN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          // Resend email functionality
                          Get.find<AuthController>()
                              .sendPasswordResetEmail(email);
                        },
                        child: Text(
                          'Resend Email',
                          style: TextStyle(
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
