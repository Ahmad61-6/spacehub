import 'package:flutter/material.dart';

import '../../utility/app_colors.dart';
import '../../utility/assets_path.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _searchScreenSearchBar(),
      ),
    );
  }

  GestureDetector _searchScreenSearchBar() {
    return GestureDetector(
      onTap: () {},
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
