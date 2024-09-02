import 'package:chatty/Core/widget/Custom_Text.dart';
import 'package:chatty/features/signup/ui/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/AuthCubit/auth_cubit.dart';

class donthaveaccount extends StatelessWidget {
  const donthaveaccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
            child: SignupScreen(),
          ),
        ));
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "DONT HAVE ACCOUNT?  ",
            fontsize: 16,
            fontcolor: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          CustomText(
            text: "SIGN UP",
            fontsize: 17,
            fontcolor: Colors.blue,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}



