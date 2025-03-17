import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:spacehub/controllers/auth/password_visibility_controller.dart';
import 'package:spacehub/core/validators/email_validator.dart';
import 'package:spacehub/core/validators/password_validator.dart';
import 'package:spacehub/view/screens/auth/signup_screen.dart';
import 'package:spacehub/view/screens/widgets/top_right_toast.dart';
import 'package:spacehub/view/utility/app_colors.dart';
import 'package:spacehub/view/utility/assets_path.dart';

import '../widgets/login_other_options_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                // Title
                Center(
                  child: Column(
                    children: [
                      Image.asset(AssetsPath.appLogo),
                      const SizedBox(height: 30),
                      Text(
                        'Sign in to your account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Email Section
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
                const SizedBox(height: 24),

                // Password Section
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                GetBuilder<PasswordVisibilityController>(builder: (controller) {
                  return TextFormField(
                    controller: _passwordTEController,
                    validator: PasswordValidator.validate,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.togglePasswordVisibility();
                        },
                        icon: Icon(
                          controller.isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    obscureText: !controller.isPasswordVisible,
                  );
                }),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          color: AppColors.buttonColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        TopRightToast.show(
                            context: context,
                            message: 'Login successful',
                            color: Colors.green);
                      }
                    },
                    child: const Text(
                      'Log In',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OtherLoginOption(
                      imagePath: AssetsPath.googleLogo,
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

                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: Text(
                          'SIGN UP',
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
          ),
        ),
      ),
    );
  }
}
