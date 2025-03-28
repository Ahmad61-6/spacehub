import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:spacehub/controllers/main_bottom_nav_bar_controller.dart';
import 'package:spacehub/view/utility/app_colors.dart';

import '../utility/assets_path.dart';
import 'main_bottom_nav_screens/home_screen.dart';
import 'main_bottom_nav_screens/map_screen.dart';
import 'main_bottom_nav_screens/profile_screen.dart';
import 'main_bottom_nav_screens/search_screen.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    MapScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavBarController>(builder: (controller) {
      return Scaffold(
        body: _screens[controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: (index) => controller.changeIndex(index),
          selectedItemColor: AppColors.buttonColor,
          unselectedItemColor: AppColors.iconsCommonColor,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(AssetsPath.homeIcon), label: ''),
            BottomNavigationBarItem(
                icon: Image.asset(AssetsPath.mapIcon), label: ''),
            BottomNavigationBarItem(
                icon: Image.asset(AssetsPath.searchIcon), label: ''),
            BottomNavigationBarItem(
                icon: Image.asset(AssetsPath.profileIcon), label: '')
          ],
        ),
      );
    });
  }
}
