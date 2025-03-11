import 'package:flutter/material.dart';
import 'package:procurelineapp/Createdepartmentpage.dart';

class Managedepartmentpage extends StatefulWidget {
  const Managedepartmentpage({super.key});

  @override
  State<Managedepartmentpage> createState() => _ManagedepartmentpageState();
}

class _ManagedepartmentpageState extends State<Managedepartmentpage> {
  // Sample list of departments with added fields to match new Createdepartmentpage
  final List<Map<String, dynamic>> departments = [
    {
      'name': 'Computer Science',
      'code': 'CS',
      'head': 'Prof. John Kinyua',
      'description':
          'Department focused on computer science and technology education',
      'budget': '5000000',
      'userInCharge': 'James Olumbe'
    },
    {
      'name': 'Engineering',
      'code': 'ENG',
      'head': 'Dr. Emily Atieno',
      'description': 'Department for all engineering disciplines',
      'budget': '7500000',
      'userInCharge': 'Sarah Kerubo'
    },
    {
      'name': 'Business Administration',
      'code': 'BUS',
      'head': 'Prof. Michael Wamalwa',
      'description': 'Department for business studies and administration',
      'budget': '4200000',
      'userInCharge': 'Michael Nyangumi'
    },
    {
      'name': 'Medicine',
      'code': 'MED',
      'head': 'Dr. Sarah Juma',
      'description': 'Department focused on medical education and research',
      'budget': '9800000',
      'userInCharge': 'Emma Nyakio'
    },
    {
      'name': 'Arts and Humanities',
      'code': 'ART',
      'head': 'Prof. David Singh',
      'description': 'Department for arts, literature and humanities',
      'budget': '3500000',
      'userInCharge': 'Robert Mwangi'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Departments",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and filter section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search departments...",
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.blue[700]),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.blue[700]),
                    onPressed: () {
                      // Filter functionality
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Departments list
            Expanded(
              child: ListView.builder(
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  final department = departments[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Department icon
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                department['code'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Department details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  department['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Head: ${department['head']}",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Action buttons
                          Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  // Navigate to edit department page and create a clone
                                  // of the Createdepartmentpage with pre-filled values
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditDepartmentPage(
                                        department: department,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Delete department
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Delete Department"),
                                      content: Text(
                                        "Are you sure you want to delete ${department['name']}?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Delete logic here
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create department
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Createdepartmentpage(),
            ),
          );
        },
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Custom widget for editing departments based on Createdepartmentpage
class EditDepartmentPage extends StatefulWidget {
  final Map<String, dynamic> department;

  const EditDepartmentPage({
    Key? key,
    required this.department,
  }) : super(key: key);

  @override
  State<EditDepartmentPage> createState() => _EditDepartmentPageState();
}

class _EditDepartmentPageState extends State<EditDepartmentPage> {
  // Controllers for text fields
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _descriptionController;
  late TextEditingController _budgetController;

  // List of dummy department users for dropdown
  final List<String> _departmentUsers = [
    "Select User",
    "James Olumbe",
    "Sarah Kerubo",
    "Michael Nyangumi",
    "Emma Nyakio",
    "Robert Mwangi"
  ];

  late String _selectedUser;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing department data
    _nameController = TextEditingController(text: widget.department['name']);
    _codeController = TextEditingController(text: widget.department['code']);
    _descriptionController =
        TextEditingController(text: widget.department['description']);
    _budgetController =
        TextEditingController(text: widget.department['budget']);

    // Set the selected user from department data
    _selectedUser = widget.department['userInCharge'];
  }

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
          "Edit Department",
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
                  content: Text("Help information for editing departments"),
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
                  const Icon(Icons.edit_document, size: 28, color: Colors.blue),
                  const SizedBox(width: 12),
                  const Text(
                    "Edit Department",
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
                              content: Text("Department updated successfully"),
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
                        "Update Department",
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
