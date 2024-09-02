import 'package:chatty/features/chats/logic/cubit/chats_cubit.dart';
import 'package:chatty/features/chats/ui/widget/message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatsCubit>(context).getChats();
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
      child: BlocConsumer<ChatsCubit, ChatsState>(
        listener: (context, state) {
          if (state is Chatssuccess) {
            state.peopleChated;
          }
        },
        builder: (context, state) {
          if (state is ChatsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Chatssuccess) {
            return ListView.builder(
              itemCount: context.read<ChatsCubit>().peopleChated.length,
              itemBuilder: (context, index) {
                return MessageWidget(
                    imageurl: context
                                .read<ChatsCubit>()
                                .peopleChated[index]
                                .between['emails'][0] ==
                            FirebaseAuth.instance.currentUser!.email
                        ? context
                            .read<ChatsCubit>()
                            .peopleChated[index]
                            .between['photo'][1]
                            .toString()
                        : context
                            .read<ChatsCubit>()
                            .peopleChated[index]
                            .between['photo'][0]
                            .toString(),
                    name: context
                                .read<ChatsCubit>()
                                .peopleChated[index]
                                .between['emails'][0] ==
                            FirebaseAuth.instance.currentUser!.email
                        ? context
                            .read<ChatsCubit>()
                            .peopleChated[index]
                            .between['names'][1]
                        : context
                            .read<ChatsCubit>()
                            .peopleChated[index]
                            .between['names'][0]);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
