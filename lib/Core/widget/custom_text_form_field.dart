import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mydoctor/core/theming/colors.dart';
// import 'package:mydoctor/core/theming/styling.dart';

class customTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool? isobscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final Color? fillColor;
  final Function(String?)? validator;
  final TextEditingController? controller;
  const customTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    required this.hintText,
    this.hintStyle,
    this.style,
    this.isobscureText,
    this.suffixIcon,
    this.fillColor,
    this.validator,
    this.controller,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        return validator!(value);
      },
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? Colors.transparent,
          isDense: true,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
// Focus
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue, width: 1)),
// Enabled
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 1)),
//Error               focusedBorder: focusedBorder ??
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.3)),
// FocusedErrorBorder
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.3)),
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(fontSize: 16.sp),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon),
      obscureText: isobscureText ?? false,
      style: style ?? TextStyle(fontSize: 16.sp, color: Colors.black),
    );
  }
}
