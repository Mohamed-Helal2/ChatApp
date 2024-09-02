import 'package:chatty/Core/widget/Custom_Text.dart';
import 'package:flutter/material.dart';

class loginwithgoogle extends StatelessWidget {
  const loginwithgoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(6)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.asset("assets/images/Google.jpg"),
        const CustomText(
            text: "login with Google",
            fontsize: 15,
            fontcolor: Colors.white,
            fontWeight: FontWeight.w600),
      ]),
    );
  }
}