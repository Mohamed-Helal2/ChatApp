import 'package:chatty/features/home/logic/homecubit/home_cubit.dart';
import 'package:chatty/features/home/widget/all_user.dart';
import 'package:chatty/features/home/widget/search_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).getalluser1();

    super.initState();
    //z WidgetsBinding.instance.addObserver(this);
    // setstaus(true);
  }

  @override
  void dispose() {
    // context.read<HomeCubit>().close();
    super.dispose();
  }
  // void setstaus(bool status) async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc("1OLHVsYyZUT6iHKmRg0Q")
  //       .update({'online': status});
  // }

  // void onlinechange(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.resumed) {
  //     setstaus(true);
  //   } else {
  //     setstaus(false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<HomeCubit>(context).getalluser1();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is searchstate) {
          state.searchfu;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 60.h, left: 10.w, right: 10.w),
          child: Column(children: [
            Container(
              height: 50.h,
              child: TextField(
                onChanged: (value) {
                  context.read<HomeCubit>().searchvalue = value;
                  context.read<HomeCubit>().searchfunction();
                },
                controller: context.read<HomeCubit>().searchcontroller,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 219, 218, 218),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  suffixIcon: Icon(
                    Icons.search,
                    size: 35,
                  ),
                  hintText: "Name,Bio",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
            context.read<HomeCubit>().searchvalue == null ||
                    context.read<HomeCubit>().searchvalue == ""
                ? const AllUsers()
                : const SearchUser()
          ]),
        );
      },
    );
  }
}
