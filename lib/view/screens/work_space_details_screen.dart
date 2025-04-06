import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/view/screens/set_date_and_time_screen.dart';
import 'package:spacehub/view/utility/app_colors.dart';

import '../utility/assets_path.dart';
import '../widgets/place_card.dart';

class WorkSpaceDetailsScreen extends StatefulWidget {
  const WorkSpaceDetailsScreen({super.key});

  @override
  State<WorkSpaceDetailsScreen> createState() => _WorkSpaceDetailsScreenState();
}

class _WorkSpaceDetailsScreenState extends State<WorkSpaceDetailsScreen> {
  List imageList = [
    {'id': 1, 'image_path': AssetsPath.workSpace},
    {'id': 2, 'image_path': AssetsPath.workSpace},
    {'id': 3, 'image_path': AssetsPath.workSpace}
  ];

  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
  }

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
              padding: EdgeInsets.all(8),
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
                          height: 220.0,
                          enableInfiniteScroll: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            _currentIndex.value = index;
                          },
                          autoPlay: true,
                        ),
                        items: imageList.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.asset(item['image_path'])),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        left: 0,
                        child: ValueListenableBuilder(
                            valueListenable: _currentIndex,
                            builder: (context, index, _) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    List.generate(imageList.length, (index) {
                                  bool isActive = index == _currentIndex.value;
                                  return AnimatedContainer(
                                    height: 10,
                                    width: isActive ? 55 : 10,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: isActive ? 6 : 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: isActive
                                          ? AppColors.buttonColor
                                          : Colors.white,
                                    ),
                                    duration: Duration(milliseconds: 300),
                                  );
                                }),
                              );
                            }),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Work Hive BD",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text("(4.5)"),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  color: AppColors.iconsCommonColor),
                              const SizedBox(width: 3),
                              Text(
                                "Uttara Sector 7, Dhaka",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.iconsCommonColor
                                        .withValues(alpha: 0.8)),
                              ),
                            ],
                          ),
                          Text("BDT 799/hour", style: TextStyle(fontSize: 18))
                        ],
                      ))
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
                    Get.to(() => const SetDateAndTimeScreen());
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const PlaceCard(
                      imageUrl: AssetsPath.workSpace,
                      title: "ANZ Square Dhanmondi",
                      rating: 4.5,
                      distance: '2.0',
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
