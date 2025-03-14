import 'package:flutter/material.dart';
import 'package:procurelineapp/Prodcurementofficer/Createcategorypage.dart';
import 'package:procurelineapp/Prodcurementofficer/editcategory.dart';

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
      'userInCharge': 'James Olumbe'
    },
    {
      'name': 'IT Equipment',
      'code': 'ITE',
      'description': 'Computing and IT related equipment',
      'userInCharge': 'Sarah Kerubo'
    },
    {
      'name': 'Furniture',
      'code': 'FUR',
      'description': 'Office furniture and fittings',
      'userInCharge': 'Michael Nyangumi'
    },
    {
      'name': 'Laboratory Equipment',
      'code': 'LAB',
      'description': 'Scientific laboratory apparatus and chemicals',
      'userInCharge': 'Emma Nyakio'
    },
    {
      'name': 'Books and Publications',
      'code': 'BP',
      'description': 'Academic books, journals and publications',
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

  // Show edit dialog instead of navigating to edit page
  void _showEditDialog(Map<String, dynamic> category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Edit feature will be implemented soon for: ${category['name']}"),
        duration: const Duration(seconds: 2),
      ),
    );
    // You could implement a dialog here if you want to show something to the user
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
                              onEditPressed: () => _showEditDialog(category),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditCategoryPage(),
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
}

// Class for read-only category details
class CategoryDetailsPage extends StatefulWidget {
  final Map<String, dynamic> category;
  final Function onEditPressed;

  const CategoryDetailsPage({
    Key? key,
    required this.category,
    required this.onEditPressed,
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
                          builder: (context) => const EditCategoryPage(),
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
}
