import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/controllers/auth/auth_controller.dart';
import 'package:spacehub/controllers/user_controller.dart';
import 'package:spacehub/view/screens/booking_success_screen.dart';
import 'package:spacehub/view/utility/assets_path.dart';

import '../../controllers/date_and_time_cotroller.dart';
import '../../core/models/work_space_model.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final Workspace workspace;

  const PaymentMethodsScreen({super.key, required this.workspace});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String selectedMethod = "bKash";
  // final BookingController _bookingController = Get.find<BookingController>();
  final DateTimeController _dateTimeController = Get.find<DateTimeController>();
  final AuthController _authController = Get.find<AuthController>();
  final UserController _userController = Get.find<UserController>();

  final List<Map<String, dynamic>> paymentMethods = [
    {"title": "bKash", "image": AssetsPath.bkash, "type": "radio"},
    {"title": "Nagad", "image": AssetsPath.nagad, "type": "radio"},
    {
      "title": "American Express",
      "image": AssetsPath.amrericanExpress,
      "type": "radio"
    },
    {"title": "MasterCard", "image": AssetsPath.masterCard, "type": "arrow"},
    {"title": "Visa", "image": AssetsPath.visa, "type": "arrow"},
  ];

  Future<void> _confirmBooking() async {
    try {
      // Validate selections
      if (_dateTimeController.selectedDate == null ||
          _dateTimeController.fromTime == null ||
          _dateTimeController.toTime == null) {
        throw Exception('Please select date and time first');
      }

      // Get current user ID properly
      final currentUser = _authController.user;
      if (currentUser == null) {
        throw Exception('User not logged in');
      }

      // Create booking data
      final bookingData = {
        'workspaceId': widget.workspace.id, // Important: Add workspace ID
        'workspaceName': widget.workspace.name,
        'locationName': widget.workspace.locationName,
        'imageUrl': widget.workspace.imageUrls.isNotEmpty
            ? widget.workspace.imageUrls[0]
            : '',
        'rating': widget.workspace.rating,
        'bookingDate': Timestamp.fromDate(_dateTimeController.selectedDate!),
        'fromTime':
            '${_dateTimeController.fromTime!.hour}:${_dateTimeController.fromTime!.minute.toString().padLeft(2, '0')}',
        'toTime':
            '${_dateTimeController.toTime!.hour}:${_dateTimeController.toTime!.minute.toString().padLeft(2, '0')}',
        'totalAmount': _dateTimeController.totalAmount,
        'paymentMethod': selectedMethod,
        'createdAt': Timestamp.now(),
        'status': 'confirmed', // Add status field
      };

      // Add debug prints
      print('Adding booking for user: ${currentUser.id}');
      print('Booking data: $bookingData');

      await _userController.addBooking(bookingData);

      Get.off(() => BookingSuccessScreen());
    } catch (e) {
      Get.snackbar(
        'Booking Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      print('Booking error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("User in Payment Screen: ${_userController.user?.email}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Payment Methods",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...paymentMethods.map((method) {
              final isSelected = selectedMethod == method["title"];
              return GestureDetector(
                onTap: () {
                  if (method["type"] == "radio") {
                    setState(() {
                      selectedMethod = method["title"];
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(method["image"], height: 32, width: 32),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(method["title"],
                            style: const TextStyle(fontSize: 16)),
                      ),
                      if (method["type"] == "radio")
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: Colors.indigo,
                        )
                      else
                        const Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              );
            }).toList(),

            const Spacer(),

            // Total amount display
            GetBuilder<DateTimeController>(
              builder: (controller) => Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
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
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Confirm button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
