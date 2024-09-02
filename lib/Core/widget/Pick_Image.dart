import 'dart:io';

import 'package:chatty/features/Login/logic/AuthCubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              child: Container(
                height: 150.h,
                width: 150.w,
                decoration: context.read<AuthCubit>().profilePic == null
                    ? const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(145, 222, 222, 222),
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage("assets/images/avatar.png")))
                    : BoxDecoration(
                        color: const Color.fromARGB(145, 222, 222, 222),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: FileImage(
                            File(context.read<AuthCubit>().profilePic!.path),
                          ),
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: 0.5,
              left: 250,
              child: GestureDetector(
                onTap: () async {
                 // context.read<AuthCubit>().uloadimage();
                  ImagePicker().pickImage(source: ImageSource.gallery).then(
                      (value) => context
                          .read<AuthCubit>()
                          .uploadprofilepicture(value!));
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.camera_alt_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
