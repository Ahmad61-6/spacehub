import 'package:admin_app/controllers/admin_controller.dart';
import 'package:admin_app/screens/workspace_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final _controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final welcomeColor = isDarkMode ? Colors.white : Colors.blue.shade800;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDarkMode
                    ? [
                      Colors.grey.shade900,
                      Colors.grey.shade800,
                      Colors.grey.shade700,
                    ]
                    : [
                      Colors.blue.shade50,
                      Colors.blue.shade100,
                      Colors.blue.shade200,
                    ],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: const Text('Admin Dashboard'),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout, color: theme.colorScheme.primary),
                  onPressed: _controller.logout,
                  tooltip: 'Logout',
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.dashboard,
                              size: 72,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Welcome Back,',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: welcomeColor,
                              ),
                            ),
                            Text(
                              _controller.admin?.name ?? 'Admin',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _controller.admin?.email ?? '',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  backgroundColor: theme.colorScheme.primary,
                                ),
                                onPressed:
                                    () => Get.to(() => WorkspaceListScreen()),
                                child: const Text(
                                  'MANAGE WORKSPACES',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            if (MediaQuery.of(context).viewInsets.bottom == 0)
                              Text(
                                'Admin Dashboard v1.0',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
