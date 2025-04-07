import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/controllers/auth/auth_controller.dart';
import 'package:spacehub/controllers/auth/terms_controller.dart';
import 'package:spacehub/core/validators/name_validator.dart';
import 'package:spacehub/view/screens/auth/login_screen.dart';
import 'package:spacehub/view/utility/assets_path.dart';

import '../../../core/validators/email_validator.dart';
import '../../../core/validators/password_validator.dart';
import '../../utility/app_colors.dart';
import '../../widgets/common_auth_app_bar.dart';
import '../../widgets/login_other_options_container.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAuthAppBar(),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Create your account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _nameTEController,
                          validator: NameValidator.validate,
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'ex: jon smith'),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _emailTEController,
                          validator: EmailValidator.validate,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              hintText: 'ex: jon.smith@email.com'),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordTEController,
                          validator: PasswordValidator.validate,
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'Password'),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          obscureText: true,
                          controller: _confirmPasswordTEController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value.trim() !=
                                _passwordTEController.text.trim()) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              hintText: 'confirm Password'),
                        ),
                        Row(
                          children: [
                            GetBuilder<TermsController>(builder: (controller) {
                              return Checkbox(
                                value: controller.isChecked,
                                onChanged: controller.toggleCheckbox,
                              );
                            }),
                            const Text(
                              'I understood the terms & policy.',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        GetBuilder<AuthController>(builder: (controller) {
                          return SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: !controller.isLoading,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await controller.signUpWithEmail(
                                        _emailTEController.text.trim(),
                                        _passwordTEController.text.trim(),
                                        _nameTEController.text.trim());
                                  }
                                },
                                child: const Text(
                                  'Sign UP',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            "Or sign up with",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _authController.signInWithGoogle();
                              },
                              child: OtherLoginOption(
                                imagePath: AssetsPath.googleLogo,
                              ),
                            ),
                            const SizedBox(width: 20),
                            OtherLoginOption(
                              imagePath: AssetsPath.facebookLogo,
                            ),
                            const SizedBox(width: 20),
                            OtherLoginOption(
                              imagePath: AssetsPath.xLogo,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have an account? ",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: AppColors.buttonColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
