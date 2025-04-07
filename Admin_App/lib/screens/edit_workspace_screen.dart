import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/work_space_model.dart';
import '../service/firestore_service.dart';

class EditWorkspaceScreen extends StatefulWidget {
  final Workspace workspace;

  const EditWorkspaceScreen({super.key, required this.workspace});

  @override
  _EditWorkspaceScreenState createState() => _EditWorkspaceScreenState();
}

class _EditWorkspaceScreenState extends State<EditWorkspaceScreen> {
  late final FirestoreService _firestore;
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late String _category;

  @override
  void initState() {
    super.initState();
    _firestore = FirestoreService();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController(text: widget.workspace.name);
    _priceController = TextEditingController(
      text: widget.workspace.price.toString(),
    );
    _category = widget.workspace.category;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Workspace'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Edit Workspace Details',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Workspace Name',
                            prefixIcon: Icon(Icons.business),
                            border: OutlineInputBorder(),
                          ),
                          validator:
                              (value) => value!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _category,
                          items:
                              ['private', 'office', 'space']
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.capitalizeFirst!),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (value) => setState(() => _category = value!),
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            prefixIcon: Icon(Icons.category),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _priceController,
                          decoration: const InputDecoration(
                            labelText: 'Price per day',
                            prefixIcon: Icon(Icons.monetization_on),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator:
                              (value) => value!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Update Workspace',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final updatedWorkspace = widget.workspace.copyWith(
          name: _nameController.text,
          category: _category,
          price: double.parse(_priceController.text),
        );

        await _firestore.updateWorkspace(updatedWorkspace);
        Get.back();
        Get.snackbar('Success', 'Workspace updated successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to update workspace: ${e.toString()}');
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
