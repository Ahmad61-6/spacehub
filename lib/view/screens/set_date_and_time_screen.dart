import 'package:flutter/material.dart';

import '../utility/app_colors.dart';

class SetDateAndTimeScreen extends StatefulWidget {
  const SetDateAndTimeScreen({super.key});

  @override
  State<SetDateAndTimeScreen> createState() => _SetDateAndTimeScreenState();
}

class _SetDateAndTimeScreenState extends State<SetDateAndTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity, // Adjust width as needed
              // padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.buttonColor
                    .withValues(alpha: 0.34), // Light blue background
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // From - To Date Section
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _dateColumn('From', 'Thu, 31 Oct\n2024'),
                        Container(width: 40, height: 1.5, color: Colors.white),
                        _dateColumn('To', 'Thu, 31\nOct 2024'),
                      ],
                    ),
                  ),

                  Divider(
                    height: 1,
                    thickness: 1.0,
                    color: Colors.grey,
                  ),
                  // Time Section
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _timeColumn('AM', '12.00')),
                        Container(width: 1, height: 30, color: Colors.white),
                        // Divider
                        Expanded(child: _timeColumn('PM', '14.00')),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1.0,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  // Duration Section
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Duration',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        Text('14.00 Hours',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateColumn(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.appBackground)),
        SizedBox(height: 5),
        Text(date, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Helper Widget for Time Column
  Widget _timeColumn(String label, String time) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black54)),
        SizedBox(height: 5),
        Text(time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
