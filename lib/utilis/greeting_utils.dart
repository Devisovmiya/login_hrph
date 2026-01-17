
import 'package:intl/intl.dart';

//time based greeting message
String getGreetings() {
  final hour = DateTime.now().hour;

  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 17) {
    return 'Good AfterNoon';
  } else {
    return 'Good Evening';
  }
}

//Display Date and Time
String getDateAndTime() {
  final now = DateTime.now();

  //this EEEE - day of week, MMM - month, d - date, yyyy - year, hh - hour, mm - minute, a - AM/PM
  final formatter = DateFormat('EEEE, MMM d, yyyy • hh:mm a');
  return formatter.format(now);
}
