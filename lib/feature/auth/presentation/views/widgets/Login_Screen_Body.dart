// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/manager/cubit/app_State.dart';
import 'package:news_app/feature/auth/presentation/views/home/home_screen.dart';
import 'package:news_app/feature/auth/presentation/views/widgets/login_field.dart';
import 'package:news_app/feature/auth/presentation/views/widgets/logo_And_text.dart';
import '../../../../../core/function/flutter_toast.dart';
import '../../../../../core/widgets/defult_custom_Button.dart';
import '../../../../../data/manager/cubit/app_cubit.dart';
import '../forgot_password_screen.dart';

class LoginScreenBody extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is SuccessLoginState) {
          if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
            toastMessage(state: ToastStates.SUCCESS, text: ' Welcome Back');

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          } else if (FirebaseAuth.instance.currentUser!.emailVerified ==
              false) {
            toastMessage(
                state: ToastStates.ERROR, text: 'please verify your Email');
          }
       
        }
           else if(state is ErrorLoginState){
            toastMessage(
                state: ToastStates.ERROR, text: state.error);
          }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                 
                  LoginField(
                    emailController: AppCubit.get(context).emailController,
                    passwordController:
                        AppCubit.get(context).passwordController,
                    onpressedSuffix: () {
                      AppCubit.get(context).passwordShowSuffix();
                    },
                    iconssuffix: AppCubit.get(context).icon,
                    obscureText: AppCubit.get(context).isShow,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ));
                    },
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 230),
                  state is LodingLoginState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: CustomTextButton(
                              bottomLeft: 10,
                              bottomRight: 10,
                              topRight: 10,
                              topLeft: 10,
                              width: 270,
                              colorText: Colors.white,
                              colorContainer: Color.fromRGBO(0, 84, 190, 0),
                              text: 'Login',
                              colorBorder: Colors.black54,
                              onpressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await AppCubit.get(context)
                                      .signInWithEmailAndPassword();
                                }
                              },
                            ),
                          ),
                        ),
                
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
