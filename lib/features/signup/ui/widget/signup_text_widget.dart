import 'package:chatty/Core/widget/Custom_Text.dart';
import 'package:chatty/Core/widget/custom_text_form_field.dart';
import 'package:chatty/Core/widget/signButton_widget.dart';
import 'package:chatty/features/Login/logic/AuthCubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class signup_text extends StatelessWidget {
  const signup_text({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is passwordnotsamestate) {
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
                    text: "password should be same",
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
        return Form(
          key: context.read<AuthCubit>().formkey,
          child: Column(
            children: [
              customTextFormField(
                controller: context.read<AuthCubit>().namecontroller,
                validator: (p0) {
                  if (p0 == null || p0 == "") {
                    return "Enter Name";
                  }
                },
                prefixIcon: const Icon(
                  Icons.person,
                  size: 25,
                ),
                hintText: "Enter Name ..",
              ),
              SizedBox(
                height: 10.h,
              ),
              customTextFormField(
                controller: context.read<AuthCubit>().emailcontroller,
                validator: (p0) {
                  if (p0 == null || p0 == "") {
                    return "Enter valid Email";
                  }
                },
                prefixIcon: const Icon(
                  Icons.email,
                  size: 25,
                ),
                hintText: "Enter Email..",
              ),
              SizedBox(
                height: 10.h,
              ),
              // Enter Password
              customTextFormField(
                controller: context.read<AuthCubit>().passwordcontroller,
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<AuthCubit>().isisobscurechabge();
                  },
                  icon: Icon(
                    context.read<AuthCubit>().isobscure
                        ? FontAwesomeIcons.eyeSlash
                        : Icons.remove_red_eye_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                isobscureText: context.read<AuthCubit>().isobscure,
                validator: (p0) {
                  if (p0 == null || p0 == "") {
                    return "Enter valid password";
                  }
                },
                prefixIcon: const Icon(
                  Icons.lock,
                  size: 25,
                ),
                hintText: "Enter password..",
              ),
              SizedBox(
                height: 10.h,
              ),
              // coonfirm Password
              customTextFormField(
                controller: context.read<AuthCubit>().confirmpasswordcontroller,
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<AuthCubit>().confirmpasswordobescure();
                  },
                  icon: Icon(
                    context.read<AuthCubit>().confirmisobscure
                        ? FontAwesomeIcons.eyeSlash
                        : Icons.remove_red_eye_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                isobscureText: context.read<AuthCubit>().confirmisobscure,
                validator: (p0) {
                  if (p0 == null || p0 == "") {
                    return "Enter valid password";
                  }
                },
                prefixIcon: const Icon(
                  Icons.lock,
                  size: 25,
                ),
                hintText: "Confirm password..",
              ),
              SizedBox(
                height: 10.h,
              ),
              // Sign up
              signbutton(
                text: "Sign Up",
                onPressed0: () {
                  if (context
                      .read<AuthCubit>()
                      .formkey
                      .currentState!
                      .validate()) {
                    context.read<AuthCubit>().passwordbotsame();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
