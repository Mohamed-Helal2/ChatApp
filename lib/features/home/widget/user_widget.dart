import 'package:chatty/Core/widget/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class user_Widget extends StatelessWidget {
  const user_Widget({
    super.key,
    required this.imageurl,
    required this.name,
   
  });

  final String imageurl;
  final String name;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Color(0xff111B21),
      elevation: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 70.h,
              width: 75.w,
              decoration: imageurl =="null"
                  ? const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/avatar.png"),
                      ),
                    )
                  : BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(imageurl),
                      ),
                    )),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: name,
                  fontsize: 20,
                  fontcolor: Colors.black,
                  fontWeight: FontWeight.w800),
              const CustomText(
                  text: "status",
                  fontsize: 15,
                  fontcolor: Colors.grey,
                  fontWeight: FontWeight.w400)
            ],
          )
        ],
      ),
    );
  }
}
