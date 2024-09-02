import 'package:chatty/Core/widget/Custom_Text.dart';
import 'package:flutter/material.dart';

class alreadyhave_account extends StatelessWidget {
  const alreadyhave_account({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed("/loginpage");
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "Already HAVE ACCOUNT?  ",
            fontsize: 16,
            fontcolor: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          CustomText(
            text: "Login",
            fontsize: 17,
            fontcolor: Colors.blue,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
