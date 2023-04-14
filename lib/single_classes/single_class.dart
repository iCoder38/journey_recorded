// how many days left
// ignore_for_file: non_constant_identifier_names

class GetDifferenceBetweenDate {
  func_difference_between_date(String getDate) {
    String regex = '-';

    var fullDate =
        getDate.substring(0, 10).replaceAll(RegExp(regex, unicode: true), '');

    var year = fullDate.substring(0, 4);
    var month = fullDate.substring(4, 6);
    var day = fullDate.substring(6, 8);

    var yearToInt = int.parse(year);
    var monthToInt = int.parse(month);
    var dayToInt = int.parse(day);

    final birthday = DateTime(yearToInt, monthToInt, dayToInt);
    // final birthday = DateTime(2021, 12, 10);
    final date2 = DateTime.now();
    final difference = birthday.difference(date2).inDays;
    //
    if (difference.toString().substring(0, 1) == '-') {
      return 'overdue';
    } else {
      print('dishu 2');

      return '$difference days left';
    }
  }
}
