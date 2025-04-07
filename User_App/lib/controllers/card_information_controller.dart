import 'package:get/get.dart';

class CardInformationController extends GetxController {
  var _fromDate = '';
  var _toDate = '';
  var _fromTime = '';
  var _toTime = '';
  Duration _duration = Duration.zero;

  String get fromDate => _fromDate;

  String get toDate => _toDate;

  String get fromTime => _fromTime;

  String get toTime => _toTime;

  Duration get duration => _duration;

  void setFromDate(String fromDate) {
    _fromDate = fromDate;
    update();
  }

  void setToDate(String toDate) {
    _toDate = toDate;
    update();
  }

  void setFromTime(String fromTime) {
    _fromTime = fromTime;
    update();
  }

  void setToTime(String toTime) {
    _toTime = toTime;
    update();
  }

  void setDuration(String fromTime, String toTime) {
    // Convert time string to total minutes
    int timeToMinutes(String time) {
      List<String> parts = time.split(' ');
      List<String> timeParts = parts[0].split(':');

      int hours = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);
      String period = parts[1].toUpperCase();

      // Convert to 24-hour format
      if (period == 'PM' && hours != 12) {
        hours += 12;
      } else if (period == 'AM' && hours == 12) {
        hours = 0;
      }

      return hours * 60 + minutes;
    }

    // Calculate duration between two time strings
    Duration calculateDuration(String from, String to) {
      int fromMinutes = timeToMinutes(from);
      int toMinutes = timeToMinutes(to);

      if (toMinutes < fromMinutes) {
        toMinutes += 1440; // Add 24 hours if toTime is next day
      }

      return Duration(minutes: toMinutes - fromMinutes);
    }

    // Format Duration object as "HH hours MM minutes"
    String formatDuration(Duration duration) {
      String hours = duration.inHours.toString().padLeft(2, '0');
      String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
      return "$hours hours $minutes minutes";
    }

    // Execute logic
    _duration = calculateDuration(fromTime, toTime);
    update();
    print(formatDuration(_duration));
  }
}
