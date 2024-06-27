import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cache/shared.dart';
import 'package:news_app/core/function/check_state_auth.dart';
import 'package:news_app/core/provider/news_provider.dart';
import 'package:news_app/core/utils/bloc_observer.dart';
import 'package:news_app/core/utils/constant.dart';
import 'package:news_app/data/manager/cubit/app_cubit.dart';
import 'package:news_app/feature/auth/presentation/views/home/home_screen.dart';
import 'package:news_app/feature/auth/presentation/views/widgets/Login_BackGround.dart';
import 'package:news_app/firebase_options.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  CacheHelper().init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  late Widget widget;
  checkStateAuth();
  // debugPrint('auth:${FirebaseAuth.instance.currentUser!.uid}');
  // debugPrint(id);
  FirebaseAuth.instance.currentUser == null
      ? widget = const LoginBackGround()
      : id == ''
          ? widget = const LoginBackGround()
          : widget =  HomeScreen();

  runApp(MyApp(widget: widget));
}

class MyApp extends StatelessWidget {
  

  final Widget widget;
   MyApp({super.key, required this.widget});
 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getallusers()
       ,
      child: ChangeNotifierProvider(
        create: (_) => NewsProvider(),
        child: MaterialApp(debugShowCheckedModeBanner: false,
          title: 'News App',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Color.fromARGB(255, 246, 237, 225),
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            fontFamily: 'Poppins',
       
    
            scaffoldBackgroundColor: const Color.fromRGBO( 245, 249, 253,1),
            iconTheme: const IconThemeData(color: Colors.black),
            useMaterial3: false,
          ),
          home: widget,
        ),
      ),
    );
  }
}
