import 'package:chatty/features/chat_page/logic/message_cubit/message_cubit.dart';
import 'package:chatty/features/chat_page/ui/message_screen.dart';
import 'package:chatty/features/home/logic/homecubit/home_cubit.dart';
import 'package:chatty/features/home/widget/user_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchUser extends StatelessWidget {
  const SearchUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: context.read<HomeCubit>().Searchuser.length,
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
                      '${context.read<HomeCubit>().Searchuser[i].email}'
                    ],
                    'names': [
                      context.read<HomeCubit>().username,
                      context.read<HomeCubit>().Searchuser[i].name
                    ],
                    'photo': [
                      context.read<HomeCubit>().photourl,
                      context.read<HomeCubit>().Searchuser[i].photo
                    ]
                  },
                  last_msg: "",
                  last_time: "",
                  last_msg_from: "",
                );

                // ignore: use_build_context_synchronously
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => BlocProvider<MessageCubit>(
                    create: (context) => MessageCubit(),
                    //    value: MessageCubit(),
                    // create: (context) => MessageCubit(),
                    child: MessgaeScreen(
                      profilepic: context
                          .read<HomeCubit>()
                          .Searchuser[i]
                          .photo
                          .toString(),
                      name: context.read<HomeCubit>().Searchuser[i].name,
                      documentid: context.read<HomeCubit>().documentidz,
                    ),
                  ),
                ))
                    .then((value) {
                  context
                      .read<HomeCubit>()
                      .deletefakemessage(context.read<HomeCubit>().documentidz);
                });
                ;
              },
              child: user_Widget(
                imageurl:
                    context.read<HomeCubit>().Searchuser[i].photo.toString(),
                name: context.read<HomeCubit>().Searchuser[i].name.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}
