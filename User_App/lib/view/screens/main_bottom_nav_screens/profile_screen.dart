import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spacehub/controllers/auth/auth_controller.dart';
import 'package:spacehub/view/screens/booking_list_screen.dart';
import 'package:spacehub/view/utility/app_colors.dart';

import '../edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        elevation: 0,
        title: Text('Account', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          if (controller.user == null) {
            return Center(child: CircularProgressIndicator());
          }

          final user = controller.user!;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: user.profilePhoto != null
                          ? NetworkImage(user.profilePhoto!)
                          : null,
                      child: user.profilePhoto == null
                          ? Icon(Icons.person, size: 30)
                          : null,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Email',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey.shade500)),
                          Text(user.email,
                              style: TextStyle(
                                  color: AppColors.textColor, fontSize: 15)),
                          SizedBox(height: 6),
                          Text('Address',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey.shade500)),
                          Text(user.address ?? '',
                              style: TextStyle(
                                  color: AppColors.textColor, fontSize: 15)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Iconsax.edit),
                      onPressed: () =>
                          Get.to(() => EditProfileScreen(user: user)),
                    ),
                    Icon(Iconsax.scan_barcode),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _buildInfoBox('5', 'Spaces used')),
                    SizedBox(width: 10),
                    Expanded(
                        child:
                            _buildInfoBox('', 'Favorite', icon: Iconsax.heart)),
                    SizedBox(width: 10),
                    Expanded(
                        child:
                            _buildInfoBox('', 'History', icon: Iconsax.clock)),
                  ],
                ),
                SizedBox(height: 30),
                _buildSectionTitle('Perks for you'),
                _buildListTile(Icons.workspace_premium, 'Become a pro'),
                Divider(
                  thickness: 1,
                ),
                _buildListTile(Icons.star_border, 'Rating'),
                Divider(
                  thickness: 1,
                ),
                _buildListTile(Icons.card_giftcard, 'Bookings'),
                Divider(
                  thickness: 1,
                ),
                SizedBox(height: 15),
                _buildSectionTitle('General'),
                _buildListTile(Icons.headset_mic, 'Help'),
                _buildListTile(Icons.privacy_tip, 'Terms & Policies'),
                SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () => _authController.signOut(),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(double.infinity, 50),
                    side: BorderSide(color: AppColors.buttonColor),
                  ),
                  child: Text('LOG OUT',
                      style: TextStyle(color: AppColors.buttonColor)),
                ),
                SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBox(String value, String label, {IconData? icon}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.buttonColor),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.buttonColor.withValues(alpha: 0.1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(icon, size: 28, color: AppColors.welcomeScreenBackground)
          else
            Text(value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.buttonColor),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: title == 'Bookings'
          ? () {
              Get.to(() => BookingListScreen());
            }
          : () {},
    );
  }
}
