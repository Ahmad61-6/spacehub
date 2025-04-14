import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/view/screens/work_space_details_screen.dart';
import 'package:spacehub/view/utility/app_colors.dart';

import '../../../core/models/work_space_model.dart';

class WorkSpaceItem extends StatelessWidget {
  final Workspace workspace;

  const WorkSpaceItem({
    super.key,
    required this.workspace,
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
            child: workspace.imageUrls.isNotEmpty
                ? Image.network(
                    workspace.imageUrls.first,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  )
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                workspace.name,
                style: const TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.starIconColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${workspace.rating}) ${workspace.reviews} Reviews',
                    style: TextStyle(
                      color: AppColors.iconsCommonColor.withOpacity(0.8),
                      fontSize: 14,
                    ),
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
                    workspace.locationName,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.iconsCommonColor.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(
                          () => WorkSpaceDetailsScreen(workspace: workspace));
                    },
                    child: Text(
                      "Details",
                      style: TextStyle(color: AppColors.buttonColor),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
