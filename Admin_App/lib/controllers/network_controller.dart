// lib/controllers/network_controller.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../service/connectivity_service.dart';

class NetworkController extends GetxController {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  @override
  void onInit() {
    super.onInit();
    checkInitialConnection();
    _setupConnectionListener();
  }

  Future<void> checkInitialConnection() async {
    try {
      _isConnected = await _connectivityService.checkConnection();
      update();
    } catch (e) {
      _isConnected = false;
      update();
      Get.snackbar(
        'Error',
        'Failed to check network connection',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _setupConnectionListener() {
    _connectivityService.connectionStream.listen((result) {
      if (result == ConnectivityResult.none) {
        _isConnected = false;
      } else {
        _isConnected = true;
      }
      update();
      if (!_isConnected) {
        Get.snackbar(
          'Connection Lost',
          'You are offline. Some features may not be available.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'Connection Restored',
          'You are back online',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    });
  }
}
