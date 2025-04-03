import 'package:flutter/material.dart';
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
                decoration: const InputDecoration(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "SEND",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              )
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
