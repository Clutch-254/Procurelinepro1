import 'package:flutter/material.dart';
import 'package:procurelineapp/Prodcurementofficer/Createcategorypage.dart';

class Managecategory extends StatefulWidget {
  const Managecategory({super.key});

  @override
  State<Managecategory> createState() => _ManagecategoryState();
}

class _ManagecategoryState extends State<Managecategory> {
  // Controller for the scrollable list
  final ScrollController _scrollController = ScrollController();

  // Sample list of categories
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Office Supplies',
      'code': 'OS',
      'description': 'General office supplies like stationery and equipment',
      'budget': '1500000',
      'userInCharge': 'James Olumbe'
    },
    {
      'name': 'IT Equipment',
      'code': 'ITE',
      'description': 'Computing and IT related equipment',
      'budget': '3000000',
      'userInCharge': 'Sarah Kerubo'
    },
    {
      'name': 'Furniture',
      'code': 'FUR',
      'description': 'Office furniture and fittings',
      'budget': '2500000',
      'userInCharge': 'Michael Nyangumi'
    },
    {
      'name': 'Laboratory Equipment',
      'code': 'LAB',
      'description': 'Scientific laboratory apparatus and chemicals',
      'budget': '4500000',
      'userInCharge': 'Emma Nyakio'
    },
    {
      'name': 'Books and Publications',
      'code': 'BP',
      'description': 'Academic books, journals and publications',
      'budget': '1200000',
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

  // Function to scroll to a specific category index
  void scrollToIndex(int index) {
    if (index < 0 || index >= categories.length) return;

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
          "Manage Categories",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[700],
        elevation: 4,
        actions: [
          // Added button to scroll down to a sample category (for demonstration)
          IconButton(
            icon: const Icon(Icons.arrow_downward),
            onPressed: () {
              // Scroll to the third category in the list
              scrollToIndex(2);
            },
            tooltip: "Scroll to Furniture category",
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
                        hintText: "Search categories...",
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.amber[700]),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.amber[700]),
                    onPressed: () {
                      // Filter functionality
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Categories list
            Expanded(
              child: ListView.builder(
                controller: _scrollController, // Add the scroll controller
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        // Navigate to category details page when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailsPage(
                              category: category,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // Category icon
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.amber[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  category['code'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber[800],
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            // Category details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Budget: Ksh ${_formatCurrency(category['budget'])}",
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
                                      color: Colors.amber),
                                  onPressed: () {
                                    // Navigate to edit category page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditCategoryPage(
                                          category: category,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    // Delete category
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Delete Category"),
                                        content: Text(
                                          "Are you sure you want to delete ${category['name']}?",
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
              // Navigate to create category page (updated from pushNamed to direct push)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Createcategorypage(),
                ),
              );
            },
            heroTag: 'addCategory',
            backgroundColor: Colors.amber[700],
            child: const Icon(Icons.add),
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

// Class for read-only category details
class CategoryDetailsPage extends StatefulWidget {
  final Map<String, dynamic> category;

  const CategoryDetailsPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
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
          "${widget.category['name']} Category",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber[700],
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
              // Category header with icon
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        widget.category['code'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[800],
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
                          widget.category['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Category Code: ${widget.category['code']}",
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

              // Category Information Section
              _buildSectionTitle("Category Information"),
              const SizedBox(height: 16),

              // Category Description
              _buildInfoItem(context, "Description",
                  widget.category['description'], Icons.description),
              const Divider(height: 24),

              // User in Charge
              _buildInfoItem(
                  context,
                  "User in Charge",
                  widget.category['userInCharge'],
                  Icons.supervised_user_circle),

              const SizedBox(height: 32),

              // Budget Information Section
              _buildSectionTitle("Budget Information"),
              const SizedBox(height: 16),

              // Category Budget
              _buildInfoItem(
                context,
                "Annual Budget",
                "Ksh ${_formatCurrency(widget.category['budget'])}",
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
                          builder: (context) => EditCategoryPage(
                            category: widget.category,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Category"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
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
          color: Colors.amber[700],
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
            color: Colors.amber[700],
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

// Class for editing categories
class EditCategoryPage extends StatefulWidget {
  final Map<String, dynamic> category;

  const EditCategoryPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  // Scroll controller for edit page
  final ScrollController _editScrollController = ScrollController();

  // Controllers for text fields
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _descriptionController;
  late TextEditingController _budgetController;

  // List of dummy category users for dropdown
  final List<String> _categoryUsers = [
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

    // Initialize controllers with existing category data
    _nameController = TextEditingController(text: widget.category['name']);
    _codeController = TextEditingController(text: widget.category['code']);
    _descriptionController =
        TextEditingController(text: widget.category['description']);
    _budgetController = TextEditingController(text: widget.category['budget']);

    // Set the selected user from category data
    _selectedUser = widget.category['userInCharge'];
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
          "Edit Category",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.amber[700],
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
                  content: Text("Help information for editing categories"),
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
                  const Icon(Icons.edit_document,
                      size: 28, color: Colors.amber),
                  const SizedBox(width: 12),
                  const Text(
                    "Edit Category",
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

              // Category Name
              _buildTextField(
                controller: _nameController,
                label: "Category Name",
                hint: "Enter category name",
                icon: Icons.category,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Category Code
              _buildTextField(
                controller: _codeController,
                label: "Category Code",
                hint: "Enter unique identifier code",
                icon: Icons.code,
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

              // Budget Section
              _buildSectionTitle("Budget Information"),
              const SizedBox(height: 16),

              // Category Budget
              _buildTextField(
                controller: _budgetController,
                label: "Category Budget",
                hint: "Enter annual budget allocation",
                icon: Icons.account_balance_wallet,
                isRequired: true,
                keyboardType: TextInputType.number,
                prefix: "Ksh",
              ),
              const SizedBox(height: 28),

              // User Assignment Section
              _buildSectionTitle("Category User Assignment"),
              const SizedBox(height: 16),

              // Category User Dropdown
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
                    hint: const Text("Select Category User"),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedUser = newValue!;
                      });
                    },
                    items: _categoryUsers
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
                        style: TextStyle(fontSize: 16),
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
                              content: Text("Category updated successfully"),
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
                        "Update Category",
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

    if (_codeController.text.isEmpty) {
      _showValidationError("Category code is required");
      return false;
    }

    if (_budgetController.text.isEmpty) {
      _showValidationError("Category budget is required");
      return false;
    }

    if (_selectedUser == "Select User") {
      _showValidationError("Please select a category user");
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
