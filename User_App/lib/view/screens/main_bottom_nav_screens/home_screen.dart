import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/controllers/auth/auth_controller.dart';
import 'package:spacehub/controllers/category_controller.dart';
import 'package:spacehub/controllers/main_bottom_nav_bar_controller.dart';
import 'package:spacehub/view/utility/assets_path.dart';

import '../../utility/app_colors.dart';
import '../../widgets/work_space/work_space_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homeScreenAppBar(),
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed-height header section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _homeScreenSearchBar(),
                  const SizedBox(height: 24),
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  GetBuilder<CategoryController>(
                    builder: (controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ['Private', 'Office', 'Space']
                            .map(
                              (category) => GestureDetector(
                                onTap: () =>
                                    controller.selectCategory(category),
                                child: Container(
                                  width: 105,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 29,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        controller.selectedCategory == category
                                            ? AppColors.buttonColor
                                            : AppColors.buttonColor
                                                .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color: controller.selectedCategory ==
                                              category
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recommendation',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'see all',
                        style: TextStyle(color: AppColors.buttonColor),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            // Expanded ListView that takes remaining space
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: 5, // Replace with your actual item count
                itemBuilder: (context, index) {
                  return WorkSpaceItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _homeScreenAppBar() {
    return AppBar(
      backgroundColor: AppColors.appBackground,
      leading: IconButton(
        onPressed: () {},
        icon: Image.asset(AssetsPath.sidebarIcon),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              Get.find<MainBottomNavBarController>().goToProfile();
            },
            child: GetBuilder<AuthController>(builder: (controller) {
              return CircleAvatar(
                radius: 25,
                child: controller.user?.profilePhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(controller.user!.profilePhoto!))
                    : Icon(
                        Icons.person_outline,
                        color: AppColors.buttonColor,
                      ),
              );
            }),
          ),
        )
      ],
      centerTitle: true,
      title: const Text(
        'Home',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  GestureDetector _homeScreenSearchBar() {
    return GestureDetector(
      onTap: () {
        Get.find<MainBottomNavBarController>().goToSearch();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.appBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.buttonColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Image.asset(
                AssetsPath.searchbarIcon,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 10),
              Text(
                'Search',
                style: TextStyle(
                  color: AppColors.iconsCommonColor.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
            ]),
            Icon(
              Icons.keyboard_voice_outlined,
              color: AppColors.iconsCommonColor.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
