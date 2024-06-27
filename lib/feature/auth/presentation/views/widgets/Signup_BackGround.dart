import 'package:flutter/material.dart';
import 'package:news_app/core/utils/colors.dart';
import 'package:news_app/feature/auth/presentation/views/signup_Screen.dart';
import 'package:news_app/feature/auth/presentation/views/widgets/have_an_account.dart';

import '../../../../../core/utils/assets.dart';

class SignupBackGround extends StatelessWidget {
  const SignupBackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                   Text('MyNews',style: heading,),const SizedBox(height: 130),
                   
                    Container(
                    
                      width: double.infinity,
                      height: 620,
                     
                      
                      child: const SignupScreen(),
                    ),
            
                const HaveAnAccountAndNav(
                  navegatetologin: true,
                  text: 'Already have an account !',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
