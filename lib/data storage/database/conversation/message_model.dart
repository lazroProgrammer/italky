
class Message{
  final String sender;
  final String message;
  final DateTime date;
  bool seen=false;
  Message({required this.sender, required this.message, required this.date});

}