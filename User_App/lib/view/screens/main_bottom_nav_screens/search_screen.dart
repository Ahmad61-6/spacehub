import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/controllers/search_controller.dart';
import 'package:spacehub/view/utility/app_colors.dart';
import 'package:spacehub/view/utility/assets_path.dart';
import 'package:spacehub/view/widgets/place_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController = TextEditingController();
  final _searchController = Get.find<SearchScreenController>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Workspaces",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.screenBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            GetBuilder<SearchScreenController>(
              builder: (controller) => _buildSearchResults(controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.buttonColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            AssetsPath.searchbarIcon,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                  hintText: 'Search workspace names...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false),
              onChanged: (query) {
                _searchController.searchWorkspaces(query.toUpperCase());
              },
            ),
          ),
          GetBuilder<SearchScreenController>(
            builder: (controller) {
              if (controller.searchQuery.isNotEmpty) {
                return IconButton(
                  icon: Icon(Icons.clear, color: AppColors.iconsCommonColor),
                  onPressed: () {
                    _textController.clear();
                    _searchController.clearSearch();
                  },
                );
              }
              return Icon(
                Icons.keyboard_voice_outlined,
                color: AppColors.iconsCommonColor.withOpacity(0.8),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(SearchScreenController controller) {
    if (controller.isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.buttonColor,
          ),
        ),
      );
    }

    if (controller.searchResults.isEmpty && controller.searchQuery.isNotEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'No workspaces found',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.iconsCommonColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (controller.searchResults.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'Search for workspaces by name',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.iconsCommonColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 16),
        itemCount: controller.searchResults.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final workspace = controller.searchResults[index];
          return PlaceCard(
            imageUrl: workspace.imageUrls.isNotEmpty
                ? workspace.imageUrls.first
                : AssetsPath.searchIcon,
            title: workspace.name,
            rating: workspace.rating,
            distance: workspace.locationName, // Or calculate actual distance
          );
        },
      ),
    );
  }
}
