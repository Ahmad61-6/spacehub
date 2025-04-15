import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/controllers/auth/auth_controller.dart';
import 'package:spacehub/controllers/category_controller.dart';
import 'package:spacehub/controllers/main_bottom_nav_bar_controller.dart';
import 'package:spacehub/view/utility/app_colors.dart';
import 'package:spacehub/view/utility/assets_path.dart';
import 'package:spacehub/view/widgets/work_space/work_space_item.dart';

import '../../all_work_spaces_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();
    // Load initial data when screen first loads
    // categoryController.loadWorkspaces(categoryController.selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homeScreenAppBar(),
      backgroundColor: AppColors.screenBackground,
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
                        children: ['private', 'office', 'space']
                            .map(
                              (category) => GestureDetector(
                                onTap: () =>
                                    controller.loadWorkspaces(category),
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
                                                .withValues(alpha: 0.2),
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
                      TextButton(
                        onPressed: () {
                          // Navigate to the new AllWorkspacesScreen
                          Get.to(() => const AllWorkspacesScreen());
                        },
                        child: Text(
                          'see all',
                          style: TextStyle(color: AppColors.buttonColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            // Expanded ListView that takes remaining space
            GetBuilder<CategoryController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonColor,
                      ),
                    ),
                  );
                }

                if (controller.error != null) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            controller.error!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => controller.refreshWorkspaces(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (controller.workspaces.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.work_outline,
                            size: 48,
                            color: AppColors.iconsCommonColor,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No Workspaces found',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try another category',
                            style: TextStyle(
                              color:
                                  AppColors.iconsCommonColor.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => controller.refreshWorkspaces(),
                    color: AppColors.buttonColor,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: controller.workspaces.length,
                      itemBuilder: (context, index) {
                        return WorkSpaceItem(
                          workspace: controller.workspaces[index],
                        );
                      },
                    ),
                  ),
                );
              },
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
        onPressed: () {
          // Open sidebar/drawer
          Scaffold.of(context).openDrawer();
        },
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
                backgroundColor: AppColors.buttonColor.withOpacity(0.1),
                child: controller.user?.profilePhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          controller.user!.profilePhoto!,
                          fit: BoxFit.cover,
                        ),
                      )
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
              color: AppColors.iconsCommonColor.withValues(alpha: 0.8),
            ),
          ],
        ),
      ),
    );
  }
}
