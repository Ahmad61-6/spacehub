// controllers/date_and_time_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeController extends GetxController {
  DateTime? selectedDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  String? duration;
  double totalAmount = 0.0;
  double hourlyRate = 0.0;

  void initialize(double workspacePrice) {
    hourlyRate = workspacePrice; // Assuming price is daily rate
    update();
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    _calculateDurationAndAmount();
    update();
  }

  void selectFromTime(TimeOfDay time) {
    fromTime = time;
    _calculateDurationAndAmount();
    update();
  }

  void selectToTime(TimeOfDay time) {
    toTime = time;
    _calculateDurationAndAmount();
    update();
  }

  void _calculateDurationAndAmount() {
    if (fromTime != null && toTime != null) {
      final from = DateTime(2023, 1, 1, fromTime!.hour, fromTime!.minute);
      final to = DateTime(2023, 1, 1, toTime!.hour, toTime!.minute);

      if (to.isAfter(from)) {
        final diff = to.difference(from);
        final hours = diff.inHours + (diff.inMinutes.remainder(60) / 60);
        duration = "${diff.inHours}h ${diff.inMinutes.remainder(60)}m";
        print("$hours");
        print('$hourlyRate');
        totalAmount = hours * hourlyRate;
      } else {
        duration = "Invalid time range";
        totalAmount = 0.0;
      }
    } else {
      duration = null;
      totalAmount = 0.0;
    }
  }

  String get formattedDate => selectedDate != null
      ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
      : "Select date";

  String get formattedFromTime =>
      fromTime != null ? _formatTimeWithAmPm(fromTime!) : "12:00 AM";

  String get formattedToTime =>
      toTime != null ? _formatTimeWithAmPm(toTime!) : "2:00 PM";

  String _formatTimeWithAmPm(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String get formattedDuration => duration ?? "0h 0m";

  String get formattedTotalAmount => "\$${totalAmount.toStringAsFixed(2)}";
}
