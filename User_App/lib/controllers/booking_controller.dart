// controllers/booking_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/core/models/work_space_model.dart';

import '../core/repositories/user_repository.dart';
import '../view/screens/booking_success_screen.dart';

class BookingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserRepository _userRepository = UserRepository();

  bool isLoading = false;
  List<Map<String, dynamic>> bookings = [];

  Future<void> fetchBookings(String email) async {
    try {
      isLoading = true;
      update();

      final user = await _userRepository.getUser(email);
      bookings = user?.bookings ?? [];
    } catch (e) {
      print("Error fetching bookings: $e");
      bookings = [];
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> addUserBooking({
    required String userId,
    required Workspace workspace,
    required DateTime bookingDate,
    required TimeOfDay fromTime,
    required TimeOfDay toTime,
    required double totalAmount,
    required String paymentMethod,
  }) async {
    try {
      final bookingData = {
        'workspaceName': workspace.name,
        'locationName': workspace.locationName,
        'imageUrl':
            workspace.imageUrls.isNotEmpty ? workspace.imageUrls[0] : '',
        'rating': workspace.rating,
        'bookingDate': Timestamp.fromDate(bookingDate),
        'fromTime':
            '${fromTime.hour}:${fromTime.minute.toString().padLeft(2, '0')}',
        'toTime': '${toTime.hour}:${toTime.minute.toString().padLeft(2, '0')}',
        'totalAmount': totalAmount,
        'paymentMethod': paymentMethod,
        'createdAt': Timestamp.now(),
      };

      // Debug print
      print('Attempting to add booking for user: $userId');
      print('Booking data: $bookingData');

      // Option 1: Simple update (if you're sure the document exists)
      await _firestore.collection('Users').doc(userId).update({
        'bookings': FieldValue.arrayUnion([bookingData]),
      });

      // Debug success
      print('Booking added successfully!');

      Get.snackbar('Success', 'Booking added successfully!');
      Get.to(() => BookingSuccessScreen());
    } catch (e) {
      // Debug error
      print('Error adding booking: ${e.toString()}');
      Get.snackbar('Error', 'Failed to add booking: ${e.toString()}');
      rethrow;
    }
  }
}
