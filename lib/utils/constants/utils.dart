import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  /// format price to IDR
  static String idrFormat(num price) {
    return NumberFormat.currency(locale: 'id', symbol: 'IDR ', decimalDigits: 0)
        .format(price);
  }

  static DateTime toDateTime(Timestamp time) {
    return time.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }
}
