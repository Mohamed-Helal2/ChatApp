import 'package:chatty/features/contro/logic/cubit/control_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class controlscreen extends StatefulWidget {
  const controlscreen({super.key});

  @override
  State<controlscreen> createState() => _controlscreenState();
}

class _controlscreenState extends State<controlscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlCubit, ControlState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            // shadowColor: const Color.fromARGB(255, 85, 2, 7),
            // elevation: 0.5,
            // color: Color.fromARGB(171, 255, 255, 255),

            // margin: EdgeInsets.all(8.h),
            padding: EdgeInsets.only(top: 7.h, right: 7.w, left: 7.w),
            decoration: BoxDecoration(
                //color: Color.fromARGB(127, 76, 1, 1),
                borderRadius: BorderRadius.circular(12)),
            child: NavigationBar(
              
              // backgroundColor: Color.fromARGB(127, 76, 1, 1),
              animationDuration: const Duration(seconds: 1),
              // indicatorColor: Colors.red,
              //shadowColor: Colors.blue,

              // shadowColor: Colors.black,
              // backgroundColor: Color(0xff2E7273),
              height: 60.h,
              // elevation: 0.5,
              selectedIndex: context.read<ControlCubit>().navigatorValue1,
              onDestinationSelected: (value) {
                context.read<ControlCubit>().changeSelectedvalue(value);
              },
              destinations: const [
                NavigationDestination(
                    icon: Icon(
                      Icons.video_collection_sharp,
                      size: 29,
                      // color: Colors.white,
                    ),
                    label: "Stories"),
                NavigationDestination(
                    icon: Icon(
                      Icons.home,
                      size: 29,
                    ),
                    label: "Connects"),
                NavigationDestination(
                    icon: Icon(
                      Icons.chat,
                      size: 29,
                    ),
                    label: "Chats"),
                NavigationDestination(
                    icon: Icon(
                      Icons.person,
                      size: 29,
                    ),
                    label: "Profile"),
              ],
            ),
          ),
          body: context.read<ControlCubit>().currentscreen,
        );
      },
    );
  }
}
