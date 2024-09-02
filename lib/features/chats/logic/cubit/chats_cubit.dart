import 'package:bloc/bloc.dart';
import 'package:chatty/features/chats/data/chats_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());

  List<ChatsModel> peopleChated = [];

  Future<void> getChats() async {
    try {
      emit(ChatsLoading());
      await FirebaseFirestore.instance
          .collection('messages')
          .orderBy('last_time', descending: true)
          .snapshots()
          .listen((event) {
        peopleChated.clear(); // Clear the list before adding new data
        for (var element in event.docs) {
          List emails = element['between']['emails'];
          if (emails.contains(FirebaseAuth.instance.currentUser!.email)) {
            peopleChated.add(ChatsModel.fromjson(element.data()));
          }
        }
        emit(Chatssuccess(peopleChated: peopleChated));
      });
    } catch (e) {
      emit(Chatsfailure());
    }
  }
}
