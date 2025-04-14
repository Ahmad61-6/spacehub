// card_information_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardInformationController extends GetxController {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _fromTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _toTime = const TimeOfDay(hour: 17, minute: 0);

  Duration _duration = const Duration(hours: 8);

  String get fromDate => DateFormat('dd MMM yyyy').format(_fromDate);
  String get toDate => DateFormat('dd MMM yyyy').format(_toDate);

  String get fromTime => _formatTimeOfDay(_fromTime);
  String get toTime => _formatTimeOfDay(_toTime);

  TimeOfDay get fromTimeRaw => _fromTime;
  TimeOfDay get toTimeRaw => _toTime;

  DateTime get fromDateRaw => _fromDate;
  DateTime get toDateRaw => _toDate;

  String get formattedDuration {
    final hours = _duration.inHours.toString().padLeft(2, '0');
    final minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    return "$hours.$minutes Hours";
  }

  void setFromDate(DateTime date) {
    _fromDate = date;
    _calculateDuration();
    update();
  }

  void setToDate(DateTime date) {
    _toDate = date;
    _calculateDuration();
    update();
  }

  void setFromTime(TimeOfDay time) {
    _fromTime = time;
    _calculateDuration();
    update();
  }

  void setToTime(TimeOfDay time) {
    _toTime = time;
    _calculateDuration();
    update();
  }

  void _calculateDuration() {
    final fromDateTime = DateTime(_fromDate.year, _fromDate.month,
        _fromDate.day, _fromTime.hour, _fromTime.minute);
    final toDateTime = DateTime(
        _toDate.year, _toDate.month, _toDate.day, _toTime.hour, _toTime.minute);
    _duration = toDateTime.difference(fromDateTime);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }
}
