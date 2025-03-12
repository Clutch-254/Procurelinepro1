import 'package:flutter/material.dart';

class Createcategorypage extends StatefulWidget {
  const Createcategorypage({super.key});

  @override
  State<Createcategorypage> createState() => _CreatecategorypageState();
}

class _CreatecategorypageState extends State<Createcategorypage> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  // List of dummy vote members for dropdown
  final List<String> _voteMembers = [
    "Select Member",
    "James Olumbe",
    "Sarah Kerubo",
    "Michael Nyangumi",
    "Emma Nyakio",
    "Robert Mwangi"
  ];

  // Selected members list
  final List<String> _selectedMembers = [];
  String _currentSelection = "Select Member";

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Category",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.amber[700],
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Show help information
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Help information for creating categories"),
                  duration: Duration(seconds: 3),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with divider
              Row(
                children: [
                  const Icon(Icons.category, size: 28, color: Colors.amber),
                  const SizedBox(width: 12),
                  const Text(
                    "Create New Category",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      indent: 12,
                      thickness: 1,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Category Information Section
              _buildSectionTitle("Category Information"),
              const SizedBox(height: 16),

              // Category Name
              _buildTextField(
                controller: _nameController,
                label: "Category Name",
                hint: "Enter category name",
                icon: Icons.category,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Category Description
              _buildTextField(
                controller: _descriptionController,
                label: "Category Description",
                hint: "Enter details about the category",
                icon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 28),

              // Vote Members Section
              _buildSectionTitle("Vote Members"),
              const SizedBox(height: 16),
              
              // Vote Member Selection
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelection,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(color: Colors.black87, fontSize: 16),
                          hint: const Text("Select Vote Member"),
                          onChanged: (String? newValue) {
                            setState(() {
                              _currentSelection = newValue!;
                            });
                          },
                          items: _voteMembers
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  const Icon(Icons.person,
                                      color: Colors.amber, size: 20),
                                  const SizedBox(width: 12),
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentSelection != "Select Member" && 
                            !_selectedMembers.contains(_currentSelection)) {
                          setState(() {
                            _selectedMembers.add(_currentSelection);
                            _currentSelection = "Select Member";
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Add"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Selected Members List
              if (_selectedMembers.isNotEmpty) ...[
                const Text(
                  "Selected Members:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Column(
                    children: _selectedMembers.map((member) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.person, color: Colors.amber),
                            const SizedBox(width: 12),
                            Expanded(child: Text(member)),
                            IconButton(
                              icon: const Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _selectedMembers.remove(member);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
              const SizedBox(height: 40),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.amber.shade700),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 16, color: Colors.amber),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate and save category
                        if (_validateForm()) {
                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Category created successfully"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Return to previous screen
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Create Category",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 50,
          height: 3,
          color: Colors.amber[700],
        ),
      ],
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isRequired = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? prefix,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: isRequired ? "$label *" : label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.amber[700]),
        prefixText: prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.amber.shade700, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  // Form validation
  bool _validateForm() {
    // Check required fields
    if (_nameController.text.isEmpty) {
      _showValidationError("Category name is required");
      return false;
    }

    if (_selectedMembers.isEmpty) {
      _showValidationError("Please add at least one vote member");
      return false;
    }

    // All validations passed
    return true;
  }

  // Show validation error
  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}