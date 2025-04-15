import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spacehub/controllers/user_controller.dart';
import 'package:spacehub/core/models/user_model.dart';

import '../../controllers/auth/auth_controller.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  late final UserController _userController = Get.find();
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;
  late final TextEditingController _dobController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _bioController = TextEditingController(text: widget.user.bio ?? '');
    _dobController = TextEditingController(text: widget.user.dob ?? '');
    _addressController = TextEditingController(text: widget.user.address ?? '');
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _updateProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _changeProfilePhoto,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: widget.user.profilePhoto != null
                        ? NetworkImage(widget.user.profilePhoto!)
                        : null,
                    child: widget.user.profilePhoto == null
                        ? Icon(Icons.person, size: 50)
                        : null,
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue, // Background color for the icon
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Bio (Optional)'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _dobController,
              decoration:
                  InputDecoration(labelText: 'Date of Birth (Optional)'),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  _dobController.text = date.toLocal().toString().split(' ')[0];
                }
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address (Optional)'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone (Optional)'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeProfilePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final url = await _userController.uploadProfilePhoto(
        widget.user.id!,
        image.path,
      );
      await _userController.updateProfile(
        widget.user.copyWith(profilePhoto: url),
      );
    }
  }

  Future<void> _updateProfile() async {
    final updatedUser = widget.user.copyWith(
      name: _nameController.text,
      bio: _bioController.text.isEmpty ? null : _bioController.text,
      dob: _dobController.text.isEmpty ? null : _dobController.text,
      address: _addressController.text.isEmpty ? null : _addressController.text,
      phone: _phoneController.text.isEmpty ? null : _phoneController.text,
    );

    await _userController.updateProfile(updatedUser);

    // ✅ Update user in AuthController to reflect changes in ProfileScreen
    final authController = Get.find<AuthController>();
    authController.updateUser(updatedUser);

    Get.back(); // Return to ProfileScreen
    Get.snackbar('Success', 'Profile updated successfully');
  }
}
