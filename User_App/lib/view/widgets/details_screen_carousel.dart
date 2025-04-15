import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spacehub/view/utility/app_colors.dart';

class DetailsScreenCarousel extends StatelessWidget {
  final int currentIndex;
  final List<String> imageUrls;
  final String name;
  final double rating;
  final String location;
  final double price;
  final Function(int) onPageChanged;

  const DetailsScreenCarousel({
    super.key,
    required this.currentIndex,
    required this.imageUrls,
    required this.name,
    required this.rating,
    required this.location,
    required this.price,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.buttonColor.withOpacity(0.15),
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
                    onPageChanged(index);
                  },
                  autoPlay: true,
                ),
                items: imageUrls.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(imageUrls.length, (index) {
                    bool isActive = index == currentIndex;
                    return AnimatedContainer(
                      height: 10,
                      width: isActive ? 55 : 10,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: isActive ? AppColors.buttonColor : Colors.white,
                      ),
                      duration: const Duration(milliseconds: 300),
                    );
                  }),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text("($rating)"),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
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
                        location,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.iconsCommonColor.withOpacity(0.8)),
                      ),
                    ],
                  ),
                  Text("\$$price/hour", style: const TextStyle(fontSize: 18))
                ],
              ))
        ],
      ),
    );
  }
}
