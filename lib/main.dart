import 'package:chatty/features/Login/logic/AuthCubit/auth_cubit.dart';
import 'package:chatty/features/Login/ui/login_screen.dart';
import 'package:chatty/features/home/logic/homecubit/home_cubit.dart';
import 'package:chatty/features/home/ui/home.dart';
import 'package:chatty/features/signup/ui/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChattoApp());
}

class ChattoApp extends StatelessWidget {
  const ChattoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:
              // BlocProvider<ControlCubit>(
              //   create: (context) => ControlCubit(),
              //   child: const controlscreen(),
              // ),
              BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
            child: const LoginScreen(),
          ),
          routes: {
            '/home': (context) => const HomeScreen(),
            "/loginpage": (context) => BlocProvider<AuthCubit>(
                  create: (context) => AuthCubit(),
                  child: const LoginScreen(),
                ),
            "/signupscreen": (context) => SignupScreen()
          },
        ),
      ),
    );
  }
}
