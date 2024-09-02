import 'package:chatty/Core/widget/Custom_Text.dart';
import 'package:chatty/Core/widget/Pick_Image.dart';
import 'package:chatty/features/Login/ui/widget/logingoogle_widget.dart';
import 'package:chatty/features/signup/ui/widget/alreadyhave_account_widget.dart';
import 'package:chatty/features/signup/ui/widget/signup_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Login/logic/AuthCubit/auth_cubit.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  // final GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSucess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: const Color(0xff668A74),
            content: const Row(
              children: [
                Icon(
                  Icons.gpp_good_sharp,
                  size: 25,
                  color: Colors.white,
                ),
                CustomText(
                    text: "Sucess, Now u can log in",
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
          Navigator.of(context).pushNamed("/loginpage");
        }
        if (state is SignUpFaulure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 90, 2, 13),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.error,
                  size: 25,
                  color: Colors.white,
                ),
                CustomText(
                    text: state.error_message,
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
        return Padding(
          padding: const EdgeInsets.only(top: 12, right: 10, left: 10),
          child: ListView(
            children: [
              // Icon Back
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("/loginpage");
                },
                child: Container(
                    alignment: Alignment.topLeft,
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Color.fromARGB(255, 153, 45, 52),
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
              // SignUp

              const PickImageWidget(),

              SizedBox(
                height: 10.h,
              ),
              const signup_text(),

              SizedBox(
                height: 10.h,
              ),

              const loginwithgoogle(),
              SizedBox(height: 20.h),

              const alreadyhave_account(),
            ],
          ),
        );
      },
    ));
  }
}
