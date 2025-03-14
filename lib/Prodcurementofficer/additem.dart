import 'package:flutter/material.dart';

class Additem extends StatefulWidget {
  final String categoryName;
  
  const Additem({super.key, required this.categoryName});

  @override
  State<Additem> createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _procurementMethodController = TextEditingController();
  final TextEditingController _sourceOfFundsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _unitController.dispose();
    _priceController.dispose();
    _procurementMethodController.dispose();
    _sourceOfFundsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Add Item', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                widget.categoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Enter Item Name'),
              _buildTextFormField(
                controller: _nameController,
                hintText: 'Item name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              _buildSectionTitle('Enter Item Description'),
              _buildTextFormField(
                controller: _descriptionController,
                hintText: 'Item description',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              _buildSectionTitle('Enter Unit of Management'),
              _buildTextFormField(
                controller: _unitController,
                hintText: 'e.g., Pieces, Kilograms, Boxes',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter unit of management';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              _buildSectionTitle('Enter Unit Price in Ksh'),
              _buildTextFormField(
                controller: _priceController,
                hintText: 'e.g., 1500',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter unit price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              _buildSectionTitle('Enter Procurement Method'),
              _buildTextFormField(
                controller: _procurementMethodController,
                hintText: 'e.g., Tender, Direct Purchase',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter procurement method';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              _buildSectionTitle('Enter Source of Funds'),
              _buildTextFormField(
                controller: _sourceOfFundsController,
                hintText: 'e.g., Department Budget, Grant',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter source of funds';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data and add item
                        // You can add your logic here to save the item
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        // After processing, you might want to pop back
                        // Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      validator: validator,
    );
  }
}