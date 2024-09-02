part of 'chats_cubit.dart';

@immutable
sealed class ChatsState {}

final class ChatsInitial extends ChatsState {}

final class ChatsLoading extends ChatsState {}

final class Chatssuccess extends ChatsState {
  final List peopleChated;
  Chatssuccess({required this.peopleChated});
}

final class Chatsfailure extends ChatsState {}
