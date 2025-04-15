import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/booking_controller.dart';
import '../utility/app_colors.dart';

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      init: BookingController()
        ..fetchBookings(Get.find<AuthController>().user!.email),
      builder: (controller) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.appBackground,
              title: const Text(
                'My Booking',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: const BackButton(),
              actions: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.more_vert),
                ),
              ],
              bottom: const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(width: 3.0, color: AppColors.buttonColor),
                  insets: EdgeInsets.symmetric(horizontal: 24.0),
                ),
                tabs: [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Cancelled'),
                ],
              ),
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [
                      BookingListTab(status: 'confirmed'),
                      BookingListTab(status: 'completed'),
                      BookingListTab(status: 'cancelled'),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class BookingListTab extends StatelessWidget {
  final String status;

  const BookingListTab({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (controller) {
        final filtered =
            controller.bookings.where((b) => b['status'] == status).toList();

        if (filtered.isEmpty) {
          return Center(child: Text('No $status bookings'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final booking = filtered[index];

            return BookingCard(
              imageUrl: booking['imageUrl'] ?? '',
              hotelName: booking['workspaceName'] ?? 'Workspace',
              location: booking['locationName'] ?? 'Unknown',
              rating: (booking['rating'] ?? 0).toDouble(),
              checkIn:
                  booking['bookingDate']?.toDate()?.toString().split(' ')[0] ??
                      '',
              checkOut: "${booking['fromTime']} - ${booking['toTime']}",
            );
          },
        );
      },
    );
  }
}

class BookingCard extends StatelessWidget {
  final String imageUrl;
  final String hotelName;
  final String location;
  final double rating;
  final String checkIn;
  final String checkOut;

  const BookingCard({
    super.key,
    required this.imageUrl,
    required this.hotelName,
    required this.location,
    required this.rating,
    required this.checkIn,
    required this.checkOut,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: AppColors.appBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hotelName,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(location,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('$rating',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text('Date', style: TextStyle(color: Colors.green)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14),
                        const SizedBox(width: 4),
                        Text(checkIn, style: const TextStyle(fontSize: 13)),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text('Time Slot',
                        style: TextStyle(color: Colors.red)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14),
                        const SizedBox(width: 4),
                        Text(checkOut, style: const TextStyle(fontSize: 13)),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2F3C7E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("View booking"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
