import 'package:flutter/material.dart';
import 'package:spacehub/view/widgets/date_and_time_card.dart';

import '../utility/app_colors.dart';

class SetDateAndTimeScreen extends StatefulWidget {
  const SetDateAndTimeScreen({super.key});

  @override
  State<SetDateAndTimeScreen> createState() => _SetDateAndTimeScreenState();
}

class _SetDateAndTimeScreenState extends State<SetDateAndTimeScreen> {
  void _showDateTimePickerModal() {
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      elevation: 2,
      barrierColor: Colors.transparent,
      backgroundColor: AppColors.appBackground,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 700, // Reduced height for better UX
              width: double.infinity,
              child: Column(
                children: [
                  const Text(
                    'Select Date and Time',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50),

                  // Calendar Date Picker
                  Expanded(
                      child: Container(
                    color: AppColors.buttonColor.withValues(alpha: 0.1),
                    child: Column(
                      children: [
                        Container(
                          height: 300, // Fixed height for calendar
                          child: CalendarDatePicker(
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                            onDateChanged: (DateTime date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Time Picker Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Hours
                            Column(
                              children: [
                                const Text('Hour'),
                                // NumberPicker(
                                //   minValue: 0,
                                //   maxValue: 23,
                                //   value: selectedDate.hour,
                                //   onChanged: (value) {
                                //     setState(() {
                                //       selectedDate = DateTime(
                                //         selectedDate.year,
                                //         selectedDate.month,
                                //         selectedDate.day,
                                //         value,
                                //         selectedDate.minute,
                                //       );
                                //     });
                                //   },
                                // ),
                              ],
                            ),

                            // Minutes
                            Column(
                              children: [
                                const Text('Minute'),
                                // NumberPicker(
                                //   minValue: 0,
                                //   maxValue: 59,
                                //   value: selectedDate.minute,
                                //   onChanged: (value) {
                                //     setState(() {
                                //       selectedDate = DateTime(
                                //         selectedDate.year,
                                //         selectedDate.month,
                                //         selectedDate.day,
                                //         selectedDate.hour,
                                //         value,
                                //       );
                                //     });
                                //   },
                                // ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Confirm Button
                        ElevatedButton(
                          onPressed: () {
                            print(selectedDate);
                            Navigator.pop(context, selectedDate);
                            // Use the selectedDate with time here
                          },
                          child: const Text('Confirm Selection'),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dtBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _showDateTimePickerModal,
                child: const DateAndTimeCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
