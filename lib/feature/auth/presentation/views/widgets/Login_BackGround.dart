import 'package:flutter/material.dart';
import 'package:news_app/core/utils/assets.dart';
import 'package:news_app/core/utils/colors.dart';
import 'package:news_app/feature/auth/presentation/views/login_Screen.dart';
import 'package:news_app/feature/auth/presentation/views/widgets/have_an_account.dart';

class LoginBackGround extends StatelessWidget {
  const LoginBackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MyNews',
                  style: heading
                ),
                const SizedBox(height: 200),
                Container(
                  width: double.infinity,
                  height: 530,
                  child: const LoginScreen(),
                ),
                const SizedBox(height: 20),
                const HaveAnAccountAndNav(
                  navegatetologin: false,
                  text: 'New Here?',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
