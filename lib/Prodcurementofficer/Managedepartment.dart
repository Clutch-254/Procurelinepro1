import 'package:flutter/material.dart';

import 'package:procurelineapp/Prodcurementofficer/Createdepartmentpage.dart';

class Managedepartmentpage extends StatefulWidget {
  const Managedepartmentpage({super.key});

  @override
  State<Managedepartmentpage> createState() => _ManagedepartmentpageState();
}

class _ManagedepartmentpageState extends State<Managedepartmentpage> {
  // Controller for the scrollable list
  final ScrollController _scrollController = ScrollController();

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
  void initState() {
    super.initState();
    // Optional: You can add a listener to the scroll controller for additional behaviors
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll listener for potential future use
  void _scrollListener() {
    // You can implement scroll events here, like loading more data when reaching bottom
  }

  // Function to scroll to a specific department index
  void scrollToIndex(int index) {
    if (index < 0 || index >= departments.length) return;

    // Calculate position to scroll to
    final double itemHeight = 110; // Approximate height of each card item
    final double offset = index * itemHeight;

    // Animate to that position
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

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
        actions: [
          // Added button to scroll down to a sample department (for demonstration)
          IconButton(
            icon: const Icon(Icons.arrow_downward),
            onPressed: () {
              // Scroll to the third department in the list
              scrollToIndex(2);
            },
            tooltip: "Scroll to Business Admin dept",
          ),
        ],
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
                controller: _scrollController, // Add the scroll controller
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  final department = departments[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        // Navigate to department details page when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepartmentDetailsPage(
                              department: department,
                            ),
                          ),
                        );
                      },
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
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    // Navigate to edit department page and create a clone
                                    // of the Createdepartmentpage with pre-filled values
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditDepartmentPage(
                                          department: department,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
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
                                              style:
                                                  TextStyle(color: Colors.red),
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Added scroll down button
          FloatingActionButton(
            onPressed: () {
              // Scroll to bottom
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
              );
            },
            heroTag: 'scrollDown',
            backgroundColor: Colors.grey[700],
            mini: true,
            child: const Icon(Icons.keyboard_arrow_down),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              // Navigate to create department
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Createdepartmentpage(),
                ),
              );
            },
            heroTag: 'addDepartment',
            backgroundColor: Colors.blue[700],
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

// New class for read-only department details
class DepartmentDetailsPage extends StatefulWidget {
  final Map<String, dynamic> department;

  const DepartmentDetailsPage({
    Key? key,
    required this.department,
  }) : super(key: key);

  @override
  State<DepartmentDetailsPage> createState() => _DepartmentDetailsPageState();
}

class _DepartmentDetailsPageState extends State<DepartmentDetailsPage> {
  // Scroll controller for details page
  final ScrollController _detailsScrollController = ScrollController();

  @override
  void dispose() {
    _detailsScrollController.dispose();
    super.dispose();
  }

  // Function to scroll down on the details page
  void _scrollDown() {
    _detailsScrollController.animateTo(
      _detailsScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.department['name']} Department",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 2,
        actions: [
          // Add scroll down button to app bar
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            onPressed: _scrollDown,
            tooltip: "Scroll to bottom",
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _detailsScrollController,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Department header with icon
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        widget.department['code'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.department['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Department Code: ${widget.department['code']}",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Department Information Section
              _buildSectionTitle("Department Information"),
              const SizedBox(height: 16),

              // Department Head
              _buildInfoItem(context, "Department Head",
                  widget.department['head'], Icons.person),
              const Divider(height: 24),

              // Department Description
              _buildInfoItem(context, "Description",
                  widget.department['description'], Icons.description),
              const Divider(height: 24),

              // User in Charge
              _buildInfoItem(
                  context,
                  "User in Charge",
                  widget.department['userInCharge'],
                  Icons.supervised_user_circle),

              const SizedBox(height: 32),

              // Budget Information Section
              _buildSectionTitle("Budget Information"),
              const SizedBox(height: 16),

              // Department Budget
              _buildInfoItem(
                context,
                "Annual Budget",
                "Ksh ${_formatCurrency(widget.department['budget'])}",
                Icons.account_balance_wallet,
                valueColor: Colors.green[700],
                valueFontWeight: FontWeight.bold,
              ),

              const SizedBox(height: 40),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditDepartmentPage(
                            department: widget.department,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Department"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Back to List"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Add floating action button for scrolling down
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollDown,
        mini: true,
        backgroundColor: Colors.grey[700],
        child: const Icon(Icons.keyboard_arrow_down),
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
            fontSize: 20,
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

  // Helper method to build information items
  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
    FontWeight? valueFontWeight,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue[700],
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: valueFontWeight ?? FontWeight.normal,
                    color: valueColor ?? Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to format currency
  String _formatCurrency(String amount) {
    final number = double.tryParse(amount) ?? 0;
    return number.toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
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
  // Scroll controller for edit page
  final ScrollController _editScrollController = ScrollController();

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
    _editScrollController.dispose();
    super.dispose();
  }

  // Function to scroll down on the edit page
  void _scrollDown() {
    _editScrollController.animateTo(
      _editScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
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
          // Add scroll down button to app bar
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            onPressed: _scrollDown,
            tooltip: "Scroll to bottom",
          ),
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
        controller: _editScrollController,
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
      // Add floating action button for scrolling down
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollDown,
        mini: true,
        backgroundColor: Colors.grey[700],
        child: const Icon(Icons.keyboard_arrow_down),
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
