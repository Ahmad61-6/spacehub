import 'package:flutter/material.dart';

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Booking',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: const BackButton(),
          actions: const [
            Padding(padding: EdgeInsets.all(12), child: Icon(Icons.more_vert))
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            indicator: BoxDecoration(
              color: Color(0xFF2F3C7E),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BookingListTab(),
            Center(child: Text('No completed bookings')),
            Center(child: Text('No cancelled bookings')),
          ],
        ),
      ),
    );
  }
}

class BookingListTab extends StatelessWidget {
  const BookingListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        BookingCard(
          imageUrl:
              'https://media.cntraveler.com/photos/5cb63f1961b80248e1e0d0de/4:3/w_1920,c_limit/Waldorf-Astoria-Jeddah-Qasr-Al-Sharq_2019_WAJQA_Gallery_King-Guest-Room-2.jpg',
          hotelName: 'Waldorf Astoria',
          location: 'Jeddah, Saudi Arabia',
          rating: 5,
          checkIn: '12 Mar 2025',
          checkOut: '17 Mar 2025',
        ),
      ],
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
                    const Text('Check in',
                        style: TextStyle(color: Colors.green)),
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
                    const Text('Check out',
                        style: TextStyle(color: Colors.red)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14),
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
