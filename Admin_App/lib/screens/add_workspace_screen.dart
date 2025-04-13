import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/network_controller.dart';
import '../models/work_space_model.dart';
import '../service/firestore_service.dart';

class AddWorkspaceScreen extends StatefulWidget {
  const AddWorkspaceScreen({super.key});

  @override
  _AddWorkspaceScreenState createState() => _AddWorkspaceScreenState();
}

class _AddWorkspaceScreenState extends State<AddWorkspaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestore = FirestoreService();
  final NetworkController _networkController = Get.find<NetworkController>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationNameController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _facilityController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  // State variables
  String _category = 'office';
  final List<String> _facilities = [];
  final List<String> _imageUrls = [];
  bool _isLoading = false;

  void _addFacility() {
    if (!_networkController.isConnected) {
      Get.snackbar(
        'No Internet',
        'Cannot add facility without internet connection',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final facility = _facilityController.text.trim();
    if (facility.isNotEmpty && !_facilities.contains(facility)) {
      setState(() {
        _facilities.add(facility);
        _facilityController.clear();
      });
    }
  }

  void _removeFacility(int index) {
    setState(() {
      _facilities.removeAt(index);
    });
  }

  void _addImageUrl() {
    if (!_networkController.isConnected) {
      Get.snackbar(
        'No Internet',
        'Cannot add image URL without internet connection',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final url = _imageUrlController.text.trim();
    if (url.isNotEmpty && Uri.tryParse(url)?.hasAbsolutePath == true) {
      setState(() {
        _imageUrls.add(url);
        _imageUrlController.clear();
      });
    } else {
      Get.snackbar(
        'Invalid URL',
        'Please enter a valid image URL',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _removeImageUrl(int index) {
    setState(() {
      _imageUrls.removeAt(index);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_networkController.isConnected) {
      Get.snackbar(
        'No Internet',
        'Please check your internet connection and try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (_imageUrls.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add at least one image URL',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (_facilities.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add at least one facility',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final workspace = Workspace(
        name: _nameController.text,
        category: _category,
        price: double.parse(_priceController.text),
        location: GeoPoint(
          double.parse(_latController.text),
          double.parse(_longController.text),
        ),
        locationName: _locationNameController.text,
        facilities: _facilities,
        imageUrls: _imageUrls,
        rating: 0.0,
        reviews: 0,
        createdAt: DateTime.now(),
      );

      await _firestore.addWorkspace(workspace);

      Get.back();
      Get.snackbar(
        'Success',
        'Workspace added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add workspace: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey.shade800 : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Workspace'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GetBuilder<NetworkController>(
                          builder: (controller) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    controller.isConnected
                                        ? Colors.green.withOpacity(0.2)
                                        : Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    controller.isConnected
                                        ? Icons.wifi
                                        : Icons.wifi_off,
                                    color:
                                        controller.isConnected
                                            ? Colors.green
                                            : Colors.red,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    controller.isConnected
                                        ? 'Online'
                                        : 'Offline',
                                    style: TextStyle(
                                      color:
                                          controller.isConnected
                                              ? Colors.green
                                              : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Workspace Details',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        IgnorePointer(
                          ignoring: !_networkController.isConnected,
                          child: Column(
                            children: [
                              // Name Field
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Workspace Name',
                                  prefixIcon: Icon(Icons.work_outline),
                                ),
                                validator:
                                    (value) =>
                                        value!.isEmpty ? 'Required' : null,
                              ),
                              const SizedBox(height: 20),
                              // Category Dropdown
                              DropdownButtonFormField<String>(
                                value: _category,
                                items:
                                    const ['private', 'office', 'space']
                                        .map(
                                          (category) => DropdownMenuItem(
                                            value: category,
                                            child: Text(
                                              category.capitalizeFirst!,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged:
                                    (value) =>
                                        setState(() => _category = value!),
                                decoration: const InputDecoration(
                                  labelText: 'Category',
                                  prefixIcon: Icon(Icons.category),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Price Field
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _priceController,
                                decoration: const InputDecoration(
                                  labelText: 'Price per day (\$)',
                                  prefixIcon: Icon(Icons.attach_money),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) return 'Required';
                                  if (double.tryParse(value) == null)
                                    return 'Invalid number';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              // Location Name
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _locationNameController,
                                decoration: const InputDecoration(
                                  labelText: 'Location Name',
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                ),
                                validator:
                                    (value) =>
                                        value!.isEmpty ? 'Required' : null,
                              ),
                              const SizedBox(height: 20),
                              // Coordinates
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: _latController,
                                      decoration: const InputDecoration(
                                        labelText: 'Latitude',
                                        prefixIcon: Icon(Icons.map_outlined),
                                      ),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      validator: (value) {
                                        if (value!.isEmpty) return 'Required';
                                        if (double.tryParse(value) == null)
                                          return 'Invalid coordinate';
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: _longController,
                                      decoration: const InputDecoration(
                                        labelText: 'Longitude',
                                        prefixIcon: Icon(Icons.map_outlined),
                                      ),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      validator: (value) {
                                        if (value!.isEmpty) return 'Required';
                                        if (double.tryParse(value) == null)
                                          return 'Invalid coordinate';
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Facilities Section
                              const Text(
                                'Facilities',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: _facilityController,
                                      decoration: const InputDecoration(
                                        labelText: 'Add Facility',
                                        hintText: 'WiFi, Printer, Coffee, etc.',
                                      ),
                                      onFieldSubmitted: (_) => _addFacility(),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: _addFacility,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(
                                  _facilities.length,
                                  (index) => Chip(
                                    label: Text(_facilities[index]),
                                    onDeleted: () => _removeFacility(index),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Image URLs Section
                              const Text(
                                'Image URLs',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: _imageUrlController,
                                      decoration: const InputDecoration(
                                        labelText: 'Add Image URL',
                                        hintText:
                                            'https://example.com/image.jpg',
                                      ),
                                      onFieldSubmitted: (_) => _addImageUrl(),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: _addImageUrl,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(
                                  _imageUrls.length,
                                  (index) => Chip(
                                    label: SizedBox(
                                      width: 100,
                                      child: Text(
                                        _imageUrls[index],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    onDeleted: () => _removeImageUrl(index),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Submit Button
                        SizedBox(
                          height: 50,
                          child:
                              _networkController.isConnected
                                  ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor:
                                          theme.colorScheme.primary,
                                    ),
                                    onPressed: _isLoading ? null : _submit,
                                    child:
                                        _isLoading
                                            ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                            : const Text(
                                              'SAVE WORKSPACE',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                  )
                                  : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.grey,
                                    ),
                                    onPressed:
                                        () =>
                                            _networkController
                                                .checkInitialConnection(),
                                    child: const Text(
                                      'RETRY CONNECTION',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
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
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _locationNameController.dispose();
    _latController.dispose();
    _longController.dispose();
    _facilityController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
