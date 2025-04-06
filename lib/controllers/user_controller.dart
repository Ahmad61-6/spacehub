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
    if (user != null) {
      await _userRepository.addBooking(user!.email, booking);
      await fetchUserData(user!.email);
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
