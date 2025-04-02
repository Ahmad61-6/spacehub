import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spacehub/view/utility/app_colors.dart';

import '../utility/assets_path.dart';

class WorkSpaceDetailsScreen extends StatefulWidget {
  const WorkSpaceDetailsScreen({super.key});

  @override
  State<WorkSpaceDetailsScreen> createState() => _WorkSpaceDetailsScreenState();
}

class _WorkSpaceDetailsScreenState extends State<WorkSpaceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        centerTitle: true,
        title: Text(
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              height: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.buttonColor.withValues(alpha: 0.15),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 250.0,
                          enableInfiniteScroll: true,
                          viewportFraction: 1,
                        ),
                        items: [Image.asset(AssetsPath.workSpace)].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    'text $i',
                                    style: TextStyle(fontSize: 16.0),
                                  ));
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text("Facilities",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Private', 'Office', 'Space']
                  .map(
                    (category) => Expanded(
                      // Use Expanded instead of infinite width
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 6), // Add some spacing
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12, // Reduced padding for better fit
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.buttonColor
                                .withValues(alpha: 0.15), // Fixed opacity
                          ),
                          child: Text(
                            category, // Use the actual category variable
                            textAlign: TextAlign.center, // Center the text
                            style: TextStyle(
                                color: AppColors.constTextColor, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
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
                            color: AppColors.iconsCommonColor
                                .withValues(alpha: 0.9))),
                    const SizedBox(width: 25),
                    Text('Contact',
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.iconsCommonColor
                                .withValues(alpha: 0.9))),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.buttonColor, // Button color// Text color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: Text(
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
          ],
        ),
      ),
    );
  }
}
