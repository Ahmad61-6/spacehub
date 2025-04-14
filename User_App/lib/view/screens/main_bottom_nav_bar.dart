import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spacehub/controllers/main_bottom_nav_bar_controller.dart';

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
  final List<Widget> _screens = [
    const HomeScreen(),
    const MapScreen(),
    const SearchScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavBarController>(builder: (controller) {
      return Scaffold(
        body: _screens[controller.currentIndex],
        bottomNavigationBar: SizedBox(
          height: 88,
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: (index) => controller.changeIndex(index),
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.home_2, size: 30), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.location4, size: 30), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.search_normal_1, size: 30), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Iconsax.profile_circle,
                    size: 30,
                  ),
                  label: '')
            ],
          ),
        ),
      );
    });
  }
}
