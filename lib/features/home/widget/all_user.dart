import 'package:chatty/features/chat_page/logic/message_cubit/message_cubit.dart';
import 'package:chatty/features/chat_page/ui/message_screen.dart';
import 'package:chatty/features/home/logic/homecubit/home_cubit.dart';
import 'package:chatty/features/home/widget/user_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<HomeCubit>(context).getalluser1();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is getuserdatasucess) {
          state.alluser;
        }
      },
      builder: (context, state) {
        return Expanded(
            child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: context.read<HomeCubit>().testuser.length,
          //context.read<HomeCubit>().alluser.length,
          itemBuilder: (context, i) {
            return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: InkWell(
                  onTap: () async {
                    await context.read<HomeCubit>().getpeople(
                      between00: {
                        'emails': [
                          '${FirebaseAuth.instance.currentUser!.email}',
                          //  "aeko@yajoo.com"
                          '${context.read<HomeCubit>().testuser[i].email}'
                        ],
                        'names': [
                          context.read<HomeCubit>().username,
                          context.read<HomeCubit>().testuser[i].name
                        ],
                        'photo': [
                          context.read<HomeCubit>().photourl,
                          context.read<HomeCubit>().testuser[i].photo
                        ]
                      },
                      last_msg: "",
                      last_time: "",
                      last_msg_from: "",
                    );

                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider<MessageCubit>.value(
                                  value: MessageCubit(),
                                  // create: (context) => MessageCubit(),
                                  // value: MessageCubit(),
                                  child: MessgaeScreen(
                                    profilepic: context
                                        .read<HomeCubit>()
                                        .testuser[i]
                                        .photo
                                        .toString(),
                                    name: context
                                        .read<HomeCubit>()
                                        .testuser[i]
                                        .name,
                                    documentid:
                                        context.read<HomeCubit>().documentidz,
                                  ),
                                )))
                        .then((value) {
                      context.read<HomeCubit>().deletefakemessage(
                          context.read<HomeCubit>().documentidz);
                    });
                    //print("---------------------------- $value"));
                  },
                  child: user_Widget(
                    // index: i,
                    imageurl:
                        context.read<HomeCubit>().testuser[i].photo.toString(),
                    name: context.read<HomeCubit>().testuser[i].name,
                  ),
                ));
          },
        ));
      },
    );
  }
}
