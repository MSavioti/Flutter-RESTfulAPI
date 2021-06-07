import 'package:flutter/foundation.dart';

class EndPointData {
  EndPointData({@required this.value, this.date}) : assert(value != null);
  final int value;
  final DateTime date;

  @override
  String toString() {
    return 'date: $date, value: $value';
  }
}
