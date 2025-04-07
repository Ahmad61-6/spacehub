import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/controllers/auth/auth_controller.dart';
import 'package:spacehub/view/utility/app_colors.dart';

import '../edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appBackground,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _authController.signOut(),
          ),
        ],
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          if (controller.user == null) {
            return Center(child: CircularProgressIndicator());
          }

          final user = controller.user!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: user.profilePhoto != null
                        ? NetworkImage(user.profilePhoto!)
                        : null,
                    child: user.profilePhoto == null
                        ? Icon(Icons.person, size: 50)
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                _buildProfileItem('Name', user.name),
                _buildProfileItem('Email', user.email),
                if (user.bio != null) _buildProfileItem('Bio', user.bio!),
                if (user.dob != null)
                  _buildProfileItem('Date of Birth', user.dob!),
                if (user.address != null)
                  _buildProfileItem('Address', user.address!),
                if (user.phone != null) _buildProfileItem('Phone', user.phone!),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => Get.to(() => EditProfileScreen(user: user)),
                  child: Text('Update Profile'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(height: 20),
        ],
      ),
    );
  }
}
