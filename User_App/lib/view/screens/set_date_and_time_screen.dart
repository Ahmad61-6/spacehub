import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spacehub/view/screens/payment_method_screen.dart';
import 'package:spacehub/view/widgets/date_and_time_card.dart';

import '../../controllers/date_and_time_cotroller.dart';
import '../../core/models/work_space_model.dart';
import '../utility/app_colors.dart';

class SetDateAndTimeScreen extends StatefulWidget {
  const SetDateAndTimeScreen({super.key});

  @override
  State<SetDateAndTimeScreen> createState() => _SetDateAndTimeScreenState();
}

class _SetDateAndTimeScreenState extends State<SetDateAndTimeScreen> {
  final DateTimeController _dateTimeController = Get.find<DateTimeController>();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTimeController.selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      _dateTimeController.selectDate(picked);
    }
  }

  Future<void> _selectTime({required bool isFrom}) async {
    final initialTime = isFrom
        ? _dateTimeController.fromTime ?? const TimeOfDay(hour: 12, minute: 0)
        : _dateTimeController.toTime ?? const TimeOfDay(hour: 14, minute: 0);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      isFrom
          ? _dateTimeController.selectFromTime(picked)
          : _dateTimeController.selectToTime(picked);
    }
  }

  void _proceedToNext() {
    final workspace =
        Get.arguments as Workspace; // Make sure to pass the workspace
    Get.to(() => PaymentMethodsScreen(workspace: workspace));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
      ),
      backgroundColor: AppColors.dtBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              GetBuilder<DateTimeController>(
                builder: (controller) => DateAndTimeCard(
                  preferredDate: controller.formattedDate,
                  fromTime: controller.formattedFromTime,
                  toTime: controller.formattedToTime,
                  duration: controller.formattedDuration,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "When do you need it?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Date Field
              GestureDetector(
                onTap: _selectDate,
                child: GetBuilder<DateTimeController>(
                  builder: (controller) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.formattedDate,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                        ),
                        Icon(Iconsax.calendar_1, color: AppColors.buttonColor),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // From Time Field
              GestureDetector(
                onTap: () => _selectTime(isFrom: true),
                child: GetBuilder<DateTimeController>(
                  builder: (controller) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "From: ${controller.formattedFromTime}",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                        ),
                        Icon(Iconsax.clock, color: AppColors.buttonColor),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // To Time Field
              GestureDetector(
                onTap: () => _selectTime(isFrom: false),
                child: GetBuilder<DateTimeController>(
                  builder: (controller) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "To: ${controller.formattedToTime}",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                        ),
                        Icon(Iconsax.clock, color: AppColors.buttonColor),
                      ],
                    ),
                  ),
                ),
              ),

              // Spacer to push content up
              const Spacer(),

              // Total Amount Display
              GetBuilder<DateTimeController>(
                builder: (controller) => Visibility(
                  visible: controller.totalAmount > 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          controller.formattedTotalAmount,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Proceed Button
              GetBuilder<DateTimeController>(
                builder: (controller) => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (controller.selectedDate != null &&
                            controller.fromTime != null &&
                            controller.toTime != null)
                        ? _proceedToNext
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (controller.selectedDate != null &&
                              controller.fromTime != null &&
                              controller.toTime != null)
                          ? AppColors.buttonColor
                          : Colors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Proceed',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
