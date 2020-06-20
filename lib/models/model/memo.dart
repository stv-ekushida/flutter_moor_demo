import 'package:intl/intl.dart';

class Memo {
  final int id;
  final String title;
  final String content;
  final DateTime created;

  const Memo({this.id, this.title, this.content, this.created});
}

//DateTime to String
extension MemoToString on DateTime {
  String toStringCreated(DateTime created) {
    return DateFormat('yyyy-MM-dd  hh:mm').format(created);
  }
}
