import 'package:chatty/Core/widget/Custom_Text.dart';
import 'package:chatty/Core/widget/signButton_widget.dart';
import 'package:chatty/features/Login/logic/AuthCubit/auth_cubit.dart';
import 'package:chatty/features/Login/ui/widget/donthaveaccount_widget.dart';
import 'package:chatty/features/Login/ui/widget/forgetpassword_widget.dart';
import 'package:chatty/features/Login/ui/widget/login_widget.dart';
import 'package:chatty/features/Login/ui/widget/logingoogle_widget.dart';
import 'package:chatty/features/contro/logic/cubit/control_cubit.dart';
import 'package:chatty/features/contro/ui/controlpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is loginsucess) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ControlCubit(),
                child: const controlscreen(),
              ),
            ));
            //Navigator.of(context).pushNamed('/home');
          } else if (state is loginfailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              backgroundColor: Color.fromARGB(255, 90, 2, 13),
              content: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.error,
                    size: 25,
                    color: Colors.white,
                  ),
                  CustomText(
                      text: "email or password is Wrong",
                      fontsize: 15,
                      fontcolor: Colors.white,
                      fontWeight: FontWeight.w400),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 100,
                  right: 20,
                  left: 20),
            ));
          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.center, colors: [
              Color.fromARGB(255, 85, 2, 7),
              Color.fromARGB(255, 160, 143, 144),
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 80.h,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: CustomText(
                    text: "Welcome",
                    fontsize: 40,
                    fontcolor: Colors.white,
                    // align: TextAlign.left,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: CustomText(
                      text: "Lets Sign You in",
                      fontsize: 25,
                      fontcolor: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 30.h, right: 5.w, left: 5.w),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Form(
                      key: context.read<AuthCubit>().formkey,
                      child: Column(children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        const logintext(),
                        SizedBox(
                          height: 15.h,
                        ),
                        const forgetpassword(),
                        SizedBox(
                          height: 10.h,
                        ),
                        signbutton(
                          text: "Sign in",
                          onPressed0: () {
                            if (context
                                .read<AuthCubit>()
                                .formkey
                                .currentState!
                                .validate()) {
                              context.read<AuthCubit>().LogIn();
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        const loginwithgoogle(),
                        SizedBox(
                          height: 40.h,
                        ),
                        const donthaveaccount(),
                      ]),
                    ),
                  ),
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
