part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class getuserdatasucess extends HomeState {
  final List alluser;

  getuserdatasucess({required this.alluser});
}

// final class getuserdatasucess1 extends HomeState {}

final class searchstate extends HomeState {
  final String? searchfu;

  searchstate({required this.searchfu});
}

final class adduserstate extends HomeState {}

final class addstate extends HomeState {}
final class addstatefailure extends HomeState {}

final class getpeaopleitaik extends HomeState {}

final class getmessagestate extends HomeState {
  final List messages;

  getmessagestate({required this.messages});
}

final class onlinestate extends HomeState {}
