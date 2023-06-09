class AppFunctions {
  static String addNullInStart(int n) {
    if (n > 9) {
      return n.toString();
    } else {
      return '0$n';
    }
  }

  static String? getMonthName(int month) {
    switch (month) {
      case 1:
        return 'января';
      case 2:
        return 'февраля';
      case 3:
        return 'марта';
      case 4:
        return 'апреля';
      case 5:
        return 'мая';
      case 6:
        return 'июня';
      case 7:
        return 'июля';
      case 8:
        return 'августа';
      case 9:
        return 'сентября';
      case 10:
        return 'октября';
      case 11:
        return 'ноября';
      case 12:
        return 'декабря';
    }
    return null;
  }

  static String getTImeFromMs(int ms) {
    final currentDate = DateTime.now();
    final dateInDays = DateTime.parse(
        '${currentDate.year}-${addNullInStart(currentDate.month)}-${addNullInStart(currentDate.day)}');
    final gotDate = DateTime.fromMillisecondsSinceEpoch(ms);
    String pref;
    if (dateInDays.difference(gotDate).inDays == 1) {
      pref = 'вчера';
    } else if (dateInDays.difference(gotDate).inDays == 0) {
      pref = 'сегодня';
    } else {
      pref = '${gotDate.day} ${getMonthName(gotDate.month)}';
    }

    final hour = gotDate.hour;
    final minute = gotDate.minute;

    return '$pref $hour:${minute > 9 ? minute : "0$minute"}';
  }
}
