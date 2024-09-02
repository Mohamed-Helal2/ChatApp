import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Profile",
            style:
                TextStyle(fontSize: 30, color: Color.fromARGB(255, 38, 38, 1)),
          ),
        )
      ],
    );
  }
}
