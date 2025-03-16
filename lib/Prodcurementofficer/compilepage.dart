import 'package:flutter/material.dart';

class Compilepage extends StatefulWidget {
  const Compilepage({super.key});

  @override
  State<Compilepage> createState() => _CompilepageState();
}

class _CompilepageState extends State<Compilepage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  bool _isSlabVisible = false;

  // List to store dragged items in the content area
  List<String> _draggedItems = [];

  // Data for different categories
  final List<Map<String, List<String>>> _data = [
    {
      'Department': [
        'Engineering',
        'Medicine',
        'Finance',
        'Human Resources',
        'Administration',
        'Marketing',
        'Sales'
      ],
    },
    {
      'Category': [
        'IT Equipment',
        'Office Supplies',
        'Furniture',
        'Medical Equipment',
        'Stationery',
        'Cleaning Supplies'
      ],
    },
    {
      'Items': [
        'Monitors',
        'Keyboards',
        'Mouse',
        'Laptops',
        'Desktops',
        'Chairs',
        'Desks',
        'Filing Cabinets',
        'Printers'
      ],
    },
    {
      'Planned': [], // Removed contents
    },
    {
      'Actual': [], // Removed contents
    },
    {
      'Variance': [], // Removed contents
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<double>(begin: -280, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSlab(int index) {
    setState(() {
      if (_selectedIndex == index && _isSlabVisible) {
        // Close the slab
        _animationController.reverse();
        _isSlabVisible = false;
        _selectedIndex = -1;
      } else {
        // Open the slab with new content
        if (_isSlabVisible) {
          // If another slab is open, update content without animation
          _selectedIndex = index;
        } else {
          // If no slab is open, animate it in
          _selectedIndex = index;
          _animationController.forward();
          _isSlabVisible = true;
        }
      }
    });
  }

  void _addDraggedItem(String item) {
    setState(() {
      _draggedItems.add(item);
    });
  }

  String _getCategoryName(int index) {
    if (index < 0 || index >= _data.length) {
      return "";
    }
    return _data[index].keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Row(
        children: [
          // Left sidebar with red background
          Container(
            width: 100,
            color: Colors.red.shade800,
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Department icon
                _buildSidebarItem(Icons.business, "Department", 0),

                _buildDivider(),

                // Category icon
                _buildSidebarItem(Icons.category, "Category", 1),

                _buildDivider(),

                // Items icon
                _buildSidebarItem(Icons.shopping_bag, "Items", 2),

                _buildDivider(),

                // Planned icon
                _buildSidebarItem(Icons.event_note, "Planned", 3),

                _buildDivider(),

                // Actual icon
                _buildSidebarItem(Icons.check_circle, "Actual", 4),

                _buildDivider(),

                // Variance icon
                _buildSidebarItem(Icons.compare_arrows, "Variance", 5),
              ],
            ),
          ),

          // Sliding slab
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_slideAnimation.value, 0),
                child: child,
              );
            },
            child: _selectedIndex >= 0
                ? Container(
                    width: 280,
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    color: Colors.grey.shade100,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade800,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedIndex < _data.length
                                      ? _data[_selectedIndex].keys.first
                                      : "Details",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onPressed: () => _toggleSlab(_selectedIndex),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: _buildSlabContent(),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ),

          // Main content area with white background
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title bar with red background
                Container(
                  color: Colors.red.shade800,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Center(
                    child: Text(
                      "Compile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Main content area (white background with DragTarget)
                Expanded(
                  child: DragTarget<Map<String, dynamic>>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        color: candidateData.isNotEmpty
                            ? Colors
                                .blue.shade50 // Highlight when dragging over
                            : Colors.white,
                        child: _draggedItems.isEmpty
                            ? const Center(
                                child: Text(
                                  "Drag items here",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            : _buildDraggedItemsContent(),
                      );
                    },
                    onAccept: (data) {
                      _addDraggedItem("${data['category']}: ${data['item']}");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build content for dragged items
  Widget _buildDraggedItemsContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dragged Items",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _draggedItems.clear();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _draggedItems.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  title: Text(_draggedItems[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () {
                      setState(() {
                        _draggedItems.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Build content for the sliding slab based on selected index
  Widget _buildSlabContent() {
    if (_selectedIndex < 0 || _selectedIndex >= _data.length) {
      return Container();
    }

    final Map<String, List<String>> categoryData = _data[_selectedIndex];
    final String categoryName = categoryData.keys.first;
    final List<String> items = categoryData[categoryName] ?? [];

    // Check if there are no items for this category
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForCategory(categoryName),
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              "No items in $categoryName",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Draggable<Map<String, dynamic>>(
            // Data to be passed to the drop target
            data: {
              'category': categoryName,
              'item': items[index],
            },
            // Feedback widget (what you see when dragging)
            feedback: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 200,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getIconForCategory(categoryName),
                      color: Colors.red.shade800,
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        items[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Child widget (what you see before dragging)
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(
                  items[index],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.drag_indicator, color: Colors.grey),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            // Childless mode indicator
            childWhenDragging: Card(
              elevation: 0,
              color: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(
                  items[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                  ),
                ),
                trailing: Icon(
                  Icons.drag_indicator,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper method to get icon for category
  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Department':
        return Icons.business;
      case 'Category':
        return Icons.category;
      case 'Items':
        return Icons.shopping_bag;
      case 'Planned':
        return Icons.event_note;
      case 'Actual':
        return Icons.check_circle;
      case 'Variance':
        return Icons.compare_arrows;
      default:
        return Icons.list;
    }
  }

  // Helper method to build divider
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 1,
        color: Colors.white.withOpacity(0.3),
      ),
    );
  }

  // Helper method to build sidebar items with icon and text as elevated buttons
  Widget _buildSidebarItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: Material(
        color: isSelected ? Colors.red.shade700 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        elevation: isSelected ? 6 : 0,
        child: InkWell(
          onTap: () => _toggleSlab(index),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              children: [
                const SizedBox(height: 5), // This lowers the icons slightly
                Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 