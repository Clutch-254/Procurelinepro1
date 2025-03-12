import 'package:flutter/material.dart';

class Additem extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const Additem({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<Additem> createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();

  // List of procurement methods for dropdown
  final List<String> _procurementMethods = [
    "Select Method",
    "Direct Procurement",
    "Open Tender",
    "Restricted Tender",
    "Request for Quotation",
    "Request for Proposal",
    "Low Value Procurement"
  ];

  // List of fund sources for dropdown
  final List<String> _fundSources = [
    "Select Source",
    "Internal Budget",
    "External Grant",
    "Government Funding",
    "Development Partners",
    "Research Fund",
    "Emergency Fund"
  ];

  // Selected values for dropdowns
  String _selectedProcurementMethod = "Select Method";
  String _selectedFundSource = "Select Source";

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _unitPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Item",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green[600],
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Help information for adding items"),
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
                  Icon(Icons.add_shopping_cart,
                      size: 28, color: Colors.green[600]),
                  const SizedBox(width: 12),
                  const Text(
                    "Add New Item",
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

              // Category Information Section (Read-only)
              _buildSectionTitle("Category Information"),
              const SizedBox(height: 16),

              // Category display card (read-only)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          widget.categoryId,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                            fontSize: 18,
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
                            widget.categoryName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Category ID: ${widget.categoryId}",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Item Information Section
              _buildSectionTitle("Item Information"),
              const SizedBox(height: 16),

              // Item Name
              _buildTextField(
                controller: _nameController,
                label: "Item Name",
                hint: "Enter item name",
                icon: Icons.inventory,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Item Description
              _buildTextField(
                controller: _descriptionController,
                label: "Item Description",
                hint: "Enter details about the item",
                icon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // Unit Price
              _buildTextField(
                controller: _unitPriceController,
                label: "Unit Price",
                hint: "Enter unit price",
                icon: Icons.monetization_on,
                isRequired: true,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 28),

              // Procurement Details Section
              _buildSectionTitle("Procurement Details"),
              const SizedBox(height: 16),

              // Procurement Method Dropdown
              _buildDropdown(
                label: "Procurement Method",
                icon: Icons.shopping_bag,
                value: _selectedProcurementMethod,
                items: _procurementMethods,
                onChanged: (value) {
                  setState(() {
                    _selectedProcurementMethod = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Source of Funds Dropdown
              _buildDropdown(
                label: "Source of Funds",
                icon: Icons.account_balance_wallet,
                value: _selectedFundSource,
                items: _fundSources,
                onChanged: (value) {
                  setState(() {
                    _selectedFundSource = value!;
                  });
                },
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
                        side: BorderSide(color: Colors.green.shade600),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style:
                            TextStyle(fontSize: 16, color: Colors.green[600]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate and save item
                        if (_validateForm()) {
                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Item added successfully"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Return to previous screen
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Add Item",
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
          color: Colors.green[600],
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
        prefixIcon: label == "Unit Price"
            ? Container(
                width: 24,
                alignment: Alignment.center,
                child: Text(
                  "Ksh",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[600],
                  ),
                ),
              )
            : Icon(icon, color: Colors.green[600]),
        prefixText: label == "Unit Price" ? " " : prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.green.shade600, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  // Helper method to build dropdown fields
  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? "$label *" : label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.green[600]),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                    onChanged: onChanged,
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Form validation
  bool _validateForm() {
    // Check required fields
    if (_nameController.text.isEmpty) {
      _showValidationError("Item name is required");
      return false;
    }

    if (_unitPriceController.text.isEmpty) {
      _showValidationError("Unit price is required");
      return false;
    }

    // Validate price is a number
    if (double.tryParse(_unitPriceController.text) == null) {
      _showValidationError("Unit price must be a valid number");
      return false;
    }

    if (_selectedProcurementMethod == "Select Method") {
      _showValidationError("Please select a procurement method");
      return false;
    }

    if (_selectedFundSource == "Select Source") {
      _showValidationError("Please select a source of funds");
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
