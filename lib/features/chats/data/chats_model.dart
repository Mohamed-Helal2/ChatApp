class ChatsModel {
  final Map between;
  final String datetime;
  final String last_message_from;
  final String last_message;

  ChatsModel(
      {required this.between,
      required this.datetime,
      required this.last_message_from,
      required this.last_message});
  factory ChatsModel.fromjson(Chatsdata) {
    return ChatsModel(
        between: Chatsdata["between"],
        datetime: Chatsdata["last_time"].toString(),
        last_message_from: Chatsdata["last_msg_from"],
        last_message: Chatsdata["last_msg"]);
  }
}
