import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/view/screens/work_space_details_screen.dart';

import '../../utility/app_colors.dart';
import '../../utility/assets_path.dart';

class WorkSpaceItem extends StatelessWidget {
  const WorkSpaceItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              AssetsPath.workSpace,
              width: double.infinity,
              height: 200, // Set your desired height
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dhaka Desk',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.starIconColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(4.5)12 Review',
                    style: TextStyle(
                        color:
                            AppColors.iconsCommonColor.withValues(alpha: 0.8),
                        fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      color: AppColors.iconsCommonColor),
                  const SizedBox(width: 4),
                  Text(
                    "Uttara Sector 7, Dhaka",
                    style: TextStyle(
                        fontSize: 14,
                        color:
                            AppColors.iconsCommonColor.withValues(alpha: 0.8)),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Get.to(() => const WorkSpaceDetailsScreen());
                      },
                      child: Text(
                        "Details",
                        style: TextStyle(color: AppColors.buttonColor),
                      ))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
