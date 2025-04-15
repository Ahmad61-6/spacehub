import 'package:get/get.dart';

import '../core/models/user_model.dart';
import '../core/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  UserModel? user;

  Future<void> updateProfile(UserModel updatedUser) async {
    try {
      await _userRepository.updateUser(updatedUser);
      user = updatedUser;
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addBooking(Map<String, dynamic> booking) async {
    if (user == null || user?.id == null) {
      throw Exception('User not available');
    }

    try {
      await _userRepository.addBooking(user!.id!, booking);
      // Refresh user data
      await fetchUserData(user!.email);
      update();
    } catch (e) {
      print('error in UserController.addBooking: $e');
      rethrow;
    }
  }

  Future<void> fetchUserData(String email) async {
    user = await _userRepository.getUser(email);
    update();
  }

  Future<String> uploadProfilePhoto(String userId, String filePath) async {
    return await _userRepository.uploadProfilePhoto(userId, filePath);
  }
}
