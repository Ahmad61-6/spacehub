import 'package:flutter/material.dart';

import '../utility/app_colors.dart';

class DateAndTimeCard extends StatelessWidget {
  // final String fromDate;
  // final String toDate;
  // final String fromTime;
  // final String toTime;
  // final String duration;

  const DateAndTimeCard({
    super.key,
    // required this.fromDate,
    // required this.toDate,
    // required this.fromTime,
    // required this.toTime,
    // required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    double cardSpaceWidth = MediaQuery.of(context).size.width / 2 - 12.9;
    return Flexible(
        flex: 1,
        child: Column(children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.buttonColor
                  .withValues(alpha: 0.4), // Light blue background
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("From"),
                      Container(width: 50, height: 1.5, color: Colors.white),
                      Text("To"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
          ),
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
                      _timeColumn('AM', '12.00'),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                color: AppColors.buttonColor.withValues(alpha: 0.4),
              ),
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
                      SizedBox(
                        width: 110,
                      ),
                      _timeColumn('PM', '14.00'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1,
          ),
          Divider(
            height: 1,
            thickness: 2.0,
            color: AppColors.buttonColor.withValues(alpha: 0.25),
          ),
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.buttonColor
                  .withValues(alpha: 0.4), // Light blue background
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text('14.00 Hours',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
          ),
        ]));
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

  Widget _dateColumn(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.appBackground)),
        SizedBox(height: 5),
        Text(date, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
