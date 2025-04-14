import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/view/screens/set_date_and_time_screen.dart';
import 'package:spacehub/view/utility/app_colors.dart';
import 'package:spacehub/view/utility/assets_path.dart';
import 'package:spacehub/view/widgets/details_screen_carousel.dart';
import 'package:spacehub/view/widgets/place_card.dart';

import '../../core/models/work_space_model.dart';

class WorkSpaceDetailsScreen extends StatefulWidget {
  final Workspace workspace;

  const WorkSpaceDetailsScreen({super.key, required this.workspace});

  @override
  State<WorkSpaceDetailsScreen> createState() => _WorkSpaceDetailsScreenState();
}

class _WorkSpaceDetailsScreenState extends State<WorkSpaceDetailsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        centerTitle: true,
        title: const Text(
          "Detail",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.favorite_outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // <-- Wrap the entire content with this
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsScreenCarousel(
                currentIndex: _currentIndex,
                imageUrls: widget.workspace.imageUrls,
                name: widget.workspace.name,
                rating: widget.workspace.rating,
                location: widget.workspace.locationName,
                price: widget.workspace.price,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              const SizedBox(height: 30),
              const Text("Facilities",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              // Display facilities from workspace
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: widget.workspace.facilities.map((facility) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      facility,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1A1446),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Review',
                          style: TextStyle(
                              fontSize: 18,
                              color:
                                  AppColors.iconsCommonColor.withOpacity(0.9))),
                      const SizedBox(width: 25),
                      Text('Contact',
                          style: TextStyle(
                              fontSize: 18,
                              color:
                                  AppColors.iconsCommonColor.withOpacity(0.9))),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => SetDateAndTimeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Explore Near',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(color: AppColors.buttonColor),
                  )
                ],
              ),
              const SizedBox(height: 20),
              // Nearby places list - no need for Expanded or fixed height now
              Column(
                children: List.generate(3, (index) {
                  return const PlaceCard(
                    imageUrl: AssetsPath.workSpace,
                    title: "ANZ Square Dhanmondi",
                    rating: 4.5,
                    distance: '2.0',
                  );
                }),
              ),
              const SizedBox(height: 20), // Add some bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
