import 'package:flutter/material.dart';
import 'package:spacehub/view/widgets/date_and_time_card.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateAndTimeCard(),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Time Column
}
