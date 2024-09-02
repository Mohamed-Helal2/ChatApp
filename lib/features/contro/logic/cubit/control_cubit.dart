import 'package:bloc/bloc.dart';
import 'package:chatty/features/chats/logic/cubit/chats_cubit.dart';
import 'package:chatty/features/chats/ui/chat_screen.dart';
import 'package:chatty/features/home/ui/home.dart';
import 'package:chatty/features/profile/ui/profile_screen.dart';
import 'package:chatty/features/stories/ui/stories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'control_state.dart';

class ControlCubit extends Cubit<ControlState> {
  ControlCubit() : super(ControlInitial());
  int navigatorValue1 = 1;
  Widget currentscreen = const HomeScreen();
  void changeSelectedvalue(int selected_value) {
    navigatorValue1 = selected_value;
    switch (selected_value) {
      case 0:
        currentscreen = const StoryScreen();
        //  BlocProvider(
        //   create: (context) => FoldersCubit(),
        //   child: FolderHome(),
        // );
        break;
      case 1:
        currentscreen = HomeScreen();
        //     BlocProvider(
        //   create: (context) => HomeCubit(),
        //   child: const HomeScreen(),
        // );
        // BlocProvider(
        //   create: (context) => HomeCubit(),
        //   child: const Favourtiepage(),
        // );
        break;
      case 2:
        currentscreen = BlocProvider<ChatsCubit>(
          create: (context) => ChatsCubit(),
          child: const ChatsScreen(),
        );
        break;
      case 3:
        currentscreen = const ProfileScreen();
        break;
    }
    emit(navigatestate(navigate: navigatorValue1));
  }

}
