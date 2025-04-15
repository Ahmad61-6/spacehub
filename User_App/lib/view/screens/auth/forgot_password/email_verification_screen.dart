import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/controllers/auth/auth_controller.dart';
import 'package:spacehub/view/screens/auth/forgot_password/password_recovery_confirmation_screen.dart';
import 'package:spacehub/view/utility/app_colors.dart';

import '../../../../core/validators/email_validator.dart';
import '../../../widgets/common_auth_app_bar.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CommonAuthAppBar(
                appBarTitle: "Reset Password",
              ),
              const SizedBox(
                height: 20,
              ),
              constText(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Email',
                style: TextStyle(
                    fontSize: 18, color: AppColors.welcomeScreenBackground),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _emailTEController,
                validator: EmailValidator.validate,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'enter your email'),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<AuthController>(builder: (controller) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              controller.sendPasswordResetEmail(
                                  _emailTEController.text.trim());
                              Get.to(() => PasswordRecoveryConfirmationScreen(
                                  email: _emailTEController.text.trim()));
                            }
                          },
                    child: controller.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Send Reset Link',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                );
              })
            ],
          ),
        ),
      )),
    );
  }

  Center constText() {
    return Center(
      child: Column(
        children: [
          Text(
            "We will email you",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.constTextColor,
            ),
          ),
          const Text(
            "a otp to reset your password.",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.constTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
