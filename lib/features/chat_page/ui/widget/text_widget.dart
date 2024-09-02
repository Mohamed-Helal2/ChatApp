import 'package:flutter/material.dart';

class CustomChatBubble extends StatelessWidget {
  const CustomChatBubble({
    required this.messageText,
    required this.alignment,
    required this.color,
    super.key,
  });
  final AlignmentGeometry alignment;
  final String messageText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return
     Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
        padding:
            const EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        //   height: 50,
        //  width: 300,
        // alignment: Alignment.centerLeft,
        decoration:   BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.elliptical(25, 50),
                topLeft: Radius.elliptical(25, 50)),
            color: color
          //   Color(0xff284162)
             
             ),
        child: Text(
          messageText,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
