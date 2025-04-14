import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/controllers/work_space_controller.dart';
import 'package:spacehub/view/utility/app_colors.dart';
import 'package:spacehub/view/widgets/work_space/work_space_item.dart';

class AllWorkspacesScreen extends StatelessWidget {
  const AllWorkspacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workspaces',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: AppColors.appBackground,
        centerTitle: true,
      ),
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: GetBuilder<WorkspaceController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.buttonColor),
              );
            }

            if (controller.error != null) {
              return Center(
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
              );
            }

            if (controller.workspaces.isEmpty) {
              return Center(
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
                      'No workspaces found',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => controller.refreshWorkspaces(),
              color: AppColors.buttonColor,
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.workspaces.length,
                itemBuilder: (context, index) {
                  return WorkSpaceItem(
                    workspace: controller.workspaces[index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
