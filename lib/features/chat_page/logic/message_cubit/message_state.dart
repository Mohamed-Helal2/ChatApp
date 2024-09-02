part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class changeiconstate extends MessageState {}

final class sendmessagestate extends MessageState {}
final class sendmessageloading extends MessageState {}

final class sendmessagesucess extends MessageState {}
final class sendmessagefailure extends MessageState {}

final class getmessagestate extends MessageState {
  final List messages;

  getmessagestate({required this.messages});
}

final class showimagesstatesucess extends MessageState {
  final List images;
  final List imagenames;
  showimagesstatesucess({required this.images, required this.imagenames});
}

final class ImageSendFailure extends MessageState {}

final class ImageSendSucess extends MessageState {}

final class showimagesstatefailure extends MessageState {}

// final class ImageSendFailure extends MessageState {}

final class changephotonumberstate extends MessageState {}

final class changephotonumberstate2 extends MessageState {}

final class changetextstate extends MessageState {}

final class recordinitstate extends MessageState {}

final class startrecordstate extends MessageState {}

final class stoprecordstate extends MessageState {}

final class RecordingInProgressstate extends MessageState {
  final int duration;
  RecordingInProgressstate({required this.duration});
}

final class Playrecordstate extends MessageState {}

final class audiodurationstate extends MessageState {
  final int audioduration0;
  audiodurationstate({required this.audioduration0});
}

final class timeprogrssstate extends MessageState {
  final int timeprogrss0;
  timeprogrssstate({required this.timeprogrss0});
}

final class completestate extends MessageState {
  final PlayerState player;
  completestate({required this.player});
}

final class player1 extends MessageState {
  final PlayerState player;
  player1({required this.player});
}

final class player2 extends MessageState {
  final PlayerState player;
  player2({required this.player});
}

final class player3 extends MessageState {
  final PlayerState player;
  player3({required this.player});
}

final class player4 extends MessageState {
  final PlayerState player;
  player4({required this.player});
}
