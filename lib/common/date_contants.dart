import 'package:intl/intl.dart';

extension DateContants on DateTime {
  List<DateTime> getListNumberDate({required int numberDate}) {
    List<DateTime> listDateTime = [];
    for (int i = 1; i <= 7; i++) {
      listDateTime.add(
        DateTime(year, month, day + i),
      );
    }
    return listDateTime;
  }

  String dateToWeekday() {
    return DateFormat('E').format(this).toUpperCase();
  }

  String dateToDayAndMonth(){
    return DateFormat('dd/MM').format(this).toUpperCase();
  }

  String dateToString(){
    return DateFormat('dd-MM-yyyy').format(this);
  }
}
