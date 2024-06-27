import 'package:flutter/material.dart';
import 'package:news_app/feature/auth/presentation/views/widgets/title_header.dart';
import '../../../../../core/widgets/defult_Custom_field.dart';

class LoginField extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final IconData iconssuffix;
  final bool obscureText;
  final Function() onpressedSuffix;
  final Function(String)? onchanged;
  const LoginField({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onpressedSuffix,
    required this.iconssuffix,
    this.obscureText = false,
    this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
       
        DefultCustomfield(
          onchanged: onchanged,
          validator: (val) {
            if (val!.isEmpty) {
              return 'Enter your email';
            }
            return null;
          },
          text: 'Email',
          controller: emailController,
          iconData: Icons.email_outlined,
        ),
        
        DefultCustomfield(
          validator: (val) {
            if (val!.isEmpty) {
              return 'Enter your password';
            }
            return null;
          },
          onchanged: onchanged,
          obscureText: obscureText,
          text: 'Password',
          controller: passwordController,
          iconData: Icons.lock,
          issuffix: true,
          onpressedSuffix: onpressedSuffix,
          iconDataPrefix: iconssuffix,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
