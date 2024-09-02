import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 
class CustomText extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color fontcolor;
  final FontWeight fontWeight;
  final String? fontfamily;
  final int? maxlines;
   const CustomText({
    super.key,
    required this.text,
    required this.fontsize,
    required this.fontcolor,
    required this.fontWeight,
     this.maxlines,
      this.fontfamily, 
  });

  @override
  Widget build(BuildContext context) {
    return Text(
        maxLines: maxlines ?? 1,
        text,
        style: TextStyle(
            fontSize: fontsize.sp,
            color: fontcolor,
            fontWeight: fontWeight,
            overflow: TextOverflow.ellipsis,
            fontFamily: fontfamily ??
            
             "PTSerif"));
  }
}
