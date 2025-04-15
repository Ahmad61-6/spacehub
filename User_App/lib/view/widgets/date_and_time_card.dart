import 'package:flutter/material.dart';

import '../utility/app_colors.dart';

class DateAndTimeCard extends StatelessWidget {
  final String preferredDate;
  final String fromTime;
  final String toTime;
  final String duration;

  const DateAndTimeCard({
    super.key,
    required this.preferredDate,
    required this.fromTime,
    required this.toTime,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    double cardSpaceWidth = MediaQuery.of(context).size.width / 2 - 12.9;
    return Column(children: [
      Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.buttonColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Preferred Date",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.appBackground,
                    fontWeight: FontWeight.bold),
              ),
              Text(preferredDate,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ),
      ),
      SizedBox(height: 1),
      Divider(
        height: 1,
        thickness: 2.0,
        color: AppColors.buttonColor.withValues(alpha: 0.25),
      ),
      Row(
        children: [
          Container(
            height: 90,
            width: cardSpaceWidth,
            decoration: BoxDecoration(
              color: AppColors.buttonColor.withValues(alpha: 0.4),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  _timeColumn('From', fromTime),
                ],
              ),
            ),
          ),
          Container(
              width: 1, color: AppColors.buttonColor.withValues(alpha: 0.4)),
          Container(
            height: 90,
            width: cardSpaceWidth,
            decoration: BoxDecoration(
              color: AppColors.buttonColor.withValues(alpha: 0.4),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  SizedBox(width: 95),
                  _timeColumn('To', toTime),
                ],
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 1),
      Divider(
        height: 1,
        thickness: 2.0,
        color: AppColors.buttonColor.withValues(alpha: 0.25),
      ),
      Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.buttonColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Duration',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(duration,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _timeColumn(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10),
        Text(time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
