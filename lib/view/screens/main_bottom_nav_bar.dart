import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:spacehub/controllers/main_bottom_nav_bar_controller.dart';
import 'package:spacehub/view/utility/app_colors.dart';

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
          selectedItemColor: AppColors.buttonColor.withValues(alpha: 0.8),
          unselectedItemColor: AppColors.iconsCommonColor,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 30), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined, size: 30), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded, size: 30), label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_outlined,
                  size: 30,
                ),
                label: '')
          ],
        ),
      );
    });
  }
}
