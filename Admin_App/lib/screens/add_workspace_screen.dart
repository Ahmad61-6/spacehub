import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/work_space_model.dart' show Workspace;
import '../service/firestore_service.dart';

class AddWorkspaceScreen extends StatefulWidget {
  const AddWorkspaceScreen({super.key});

  @override
  _AddWorkspaceScreenState createState() => _AddWorkspaceScreenState();
}

class _AddWorkspaceScreenState extends State<AddWorkspaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestore = FirestoreService();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _category = 'office';
  final List<String> _facilities = [];
  final GeoPoint _location = const GeoPoint(0, 0);
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey.shade800 : Colors.white;

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
              title: const Text('Add New Workspace'),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
            ),
            Expanded(
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
                              _buildInputField(
                                controller: _nameController,
                                label: 'Workspace Name',
                                icon: Icons.work_outline,
                                validator:
                                    (value) =>
                                        value!.isEmpty ? 'Required' : null,
                              ),
                              const SizedBox(height: 20),
                              _buildDropdownField(
                                value: _category,
                                items: const [
                                  'office',
                                  'private',
                                  'creative',
                                  'meeting',
                                ],
                                onChanged:
                                    (value) =>
                                        setState(() => _category = value!),
                                label: 'Category',
                                icon: Icons.category,
                              ),
                              const SizedBox(height: 20),
                              _buildInputField(
                                controller: _priceController,
                                label: 'Price per day (\$)',
                                icon: Icons.attach_money,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) return 'Required';
                                  if (double.tryParse(value) == null) {
                                    return 'Enter valid number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              _buildInputField(
                                controller: _locationNameController,
                                label: 'Location Name',
                                icon: Icons.location_on_outlined,
                              ),
                              const SizedBox(height: 20),
                              _buildInputField(
                                controller: _descriptionController,
                                label: 'Description',
                                icon: Icons.description_outlined,
                                maxLines: 3,
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    backgroundColor: theme.colorScheme.primary,
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
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Theme.of(context).cardTheme.color,
      ),
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
    required String label,
    required IconData icon,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items:
          items
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.capitalizeFirst!),
                ),
              )
              .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Theme.of(context).cardTheme.color,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final workspace = Workspace(
          name: _nameController.text,
          category: _category,
          price: double.parse(_priceController.text),
          location: _location,
          locationName: _locationNameController.text,
          facilities: _facilities,
          rating: 0.0,
          reviews: 0,
          description: _descriptionController.text,
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
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _locationNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
