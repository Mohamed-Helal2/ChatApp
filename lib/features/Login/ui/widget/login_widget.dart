import 'package:chatty/Core/widget/custom_text_form_field.dart';
import 'package:chatty/features/Login/logic/AuthCubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class logintext extends StatelessWidget {
  const logintext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Card(
            shadowColor: const Color.fromARGB(255, 85, 2, 7),
            elevation: 10,
            color: const Color.fromRGBO(255, 255, 255, 0.82),
            child: Column(
              children: [
                SizedBox(
                  height: 9.h,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: const BoxDecoration(),
                  child: customTextFormField(
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
                ),
                SizedBox(
                  height: 5.h,
                ),
// password
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: customTextFormField(
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
                ),
                SizedBox(
                  height: 9.h,
                ),
              ],
            ));
      },
    );
  }
}
