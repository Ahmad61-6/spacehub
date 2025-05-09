import 'package:flutter/material.dart';
import 'package:spacehub/view/utility/app_colors.dart';

class PlaceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final String distance;

  const PlaceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.buttonColor.withAlpha(25),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl.startsWith('http')
                  ? Image.network(imageUrl,
                      width: 80, height: 80, fit: BoxFit.cover)
                  : Image.asset(imageUrl,
                      width: 80, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 5),
                      Text(
                        "($rating)",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 16, color: AppColors.iconsCommonColor),
                      const SizedBox(width: 5),
                      Text(
                        "$distance Miles",
                        style: TextStyle(
                            fontSize: 14, color: AppColors.iconsCommonColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.favorite_border, color: AppColors.iconsCommonColor),
          ],
        ),
      ),
    );
  }
}
