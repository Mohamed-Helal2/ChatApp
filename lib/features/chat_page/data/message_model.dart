class MessageModel {
  var content;
  final String type;
  final String addtime;
  final String from_email;
  String? photocaption;
  int? audiotime;
  int? audioduration;
  int? timeprogress;

  MessageModel(
      {this.content,
      required this.type,
      required this.addtime,
      required this.from_email,
      this.audiotime,
      this.audioduration,
      this.timeprogress,
      this.photocaption});
  factory MessageModel.fromjson(messagedata) {
    return MessageModel(
      content: messagedata['content'],
      type: messagedata['type'],
      addtime: messagedata['addtime'].toString(),
      from_email: messagedata['from_email'],
      audiotime: messagedata['audiotime'],
      audioduration: messagedata['audioduration'],
      timeprogress: messagedata['timeprogrss'],
      photocaption: messagedata['photocaption'],
    );
  }
}
