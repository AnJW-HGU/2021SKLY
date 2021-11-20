class Message {
  final String content;
  final DateTime sentTime;
  final String name;
  final String uid;

  Message(
      {required this.content,
      required this.sentTime,
      required this.name,
      required this.uid});
}
