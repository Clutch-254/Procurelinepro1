import 'package:flutter/material.dart';

class Createdepartmentpage extends StatefulWidget {
  const Createdepartmentpage({super.key});

  @override
  State<Createdepartmentpage> createState() => _CreatedepartmentpageState();
}

class _CreatedepartmentpageState extends State<Createdepartmentpage> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  // List of dummy department users for dropdown
  final List<String> _departmentUsers = [
    "Select User",
    "James Olumbe",
    "Sarah Kerubo",
    "Michael Nyangumi",
    "Emma Nyakio",
    "Robert Mwangi"
  ];

  String _selectedUser = "Select User";

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Department",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Show help information
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Help information for creating departments"),
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
                  const Icon(Icons.business, size: 28, color: Colors.blue),
                  const SizedBox(width: 12),
                  const Text(
                    "Create New Department",
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

              // General Information Section
              _buildSectionTitle("General Information"),
              const SizedBox(height: 16),

              // Department Name
              _buildTextField(
                controller: _nameController,
                label: "Department Name",
                hint: "Enter department name",
                icon: Icons.business,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Department Code
              _buildTextField(
                controller: _codeController,
                label: "Department Code",
                hint: "Enter unique identifier code",
                icon: Icons.code,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Department Description
              _buildTextField(
                controller: _descriptionController,
                label: "Department Description",
                hint: "Enter details about the department",
                icon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 28),

              // Budget Section
              _buildSectionTitle("Budget Information"),
              const SizedBox(height: 16),

              // Department Budget
              _buildTextField(
                controller: _budgetController,
                label: "Department Budget",
                hint: "Enter annual budget allocation",
                icon: Icons.account_balance_wallet,
                isRequired: true,
                keyboardType: TextInputType.number,
                prefix: "\Ksh",
              ),
              const SizedBox(height: 28),

              // User Assignment Section
              _buildSectionTitle("Department User Assignment"),
              const SizedBox(height: 16),

              // Department User Dropdown
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedUser,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                    hint: const Text("Select Department User"),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedUser = newValue!;
                      });
                    },
                    items: _departmentUsers
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            const Icon(Icons.person,
                                color: Colors.blue, size: 20),
                            const SizedBox(width: 12),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
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
                        side: BorderSide(color: Colors.blue.shade700),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate and save department
                        if (_validateForm()) {
                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Department created successfully"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Return to previous screen
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Create Department",
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
          color: Colors.blue[700],
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
        prefixIcon: Icon(icon, color: Colors.blue[700]),
        prefixText: prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
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
      _showValidationError("Department name is required");
      return false;
    }

    if (_codeController.text.isEmpty) {
      _showValidationError("Department code is required");
      return false;
    }

    if (_budgetController.text.isEmpty) {
      _showValidationError("Department budget is required");
      return false;
    }

    if (_selectedUser == "Select User") {
      _showValidationError("Please select a department user");
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
