// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cache/shared.dart';
import 'package:news_app/feature/auth/presentation/views/widgets/Login_BackGround.dart';
import 'package:news_app/feature/auth/presentation/views/widgets/logo_And_text.dart';
import 'package:news_app/feature/auth/presentation/views/widgets/signup_field.dart';
import '../../../../../core/function/flutter_toast.dart';
import '../../../../../core/widgets/defult_custom_Button.dart';
import '../../../../../data/manager/cubit/app_State.dart';
import '../../../../../data/manager/cubit/app_cubit.dart';

class SignupScreenBody extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  SignupScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is SuccessSignUpState) {
          CacheHelper().saveData(
            key: 'idd',
            value: state.id,
          );
          toastMessage(state: ToastStates.SUCCESS, text: 'Sign Up Successful');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginBackGround(),
            ),
          );
        } else if (state is ErrorSignUpState) {
          toastMessage(
            state: ToastStates.ERROR,
            text: state.error,
          );
        }
      },
      builder: (context, state) {
        final auth = AppCubit.get(context);
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SignupField(
                  obscureText: auth.isShow,
                  emailController: AppCubit.get(context).emailController,
                  passwordController:
                      AppCubit.get(context).passwordController,
                  nameController: AppCubit.get(context).nameController,
                   iconsuffix: auth.icon,
                  onpressedSuffix: () {
                    auth.passwordShowSuffix();
                  },
                ),
                SizedBox(height: 300,),
                Align(
                  alignment: Alignment.center,
                  child: state is LodingSignUpState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : CustomTextButton(
                          bottomLeft: 10,
                          bottomRight: 10,
                          topLeft: 10,
                          topRight: 10,
                          width: 250,
                          colorText: Colors.white,
                          colorContainer: Colors.white54,
                          text: 'Signup',
                          onpressed: () async {
                            if (formKey.currentState!.validate()) {
                              await AppCubit.get(context)
                                  .createUserWithEmailAndPassword();
                            }
                          },
                          colorBorder: Colors.black54,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
