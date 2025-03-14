import 'package:flutter/material.dart';
import 'package:procurelineapp/Prodcurementofficer/Createcategorypage.dart';
import 'package:procurelineapp/Prodcurementofficer/Additem.dart';
import 'package:procurelineapp/Prodcurementofficer/editcategory.dart';

class Managecategory extends StatefulWidget {
  const Managecategory({super.key});

  @override
  State<Managecategory> createState() => _ManagecategoryState();
}

class _ManagecategoryState extends State<Managecategory> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Office Supplies',
      'code': 'OS',
      'description': 'General office supplies like stationery and equipment',
      'budget': '1500000',
      'userInCharge': 'James Olumbe',
      'items': [
        {'name': 'Pens', 'quantity': 100, 'price': 10.0},
        {'name': 'Pencils', 'quantity': 50, 'price': 5.0},
        {'name': 'Notebooks', 'quantity': 30, 'price': 3.0},
        {'name': 'Staplers', 'quantity': 20, 'price': 15.0},
        {'name': 'Markers', 'quantity': 40, 'price': 2.0},
      ]
    },
    {
      'name': 'IT Equipment',
      'code': 'ITE',
      'description': 'Computing and IT related equipment',
      'budget': '3000000',
      'userInCharge': 'Sarah Kerubo',
      'items': [
        {'name': 'Laptops', 'quantity': 20, 'price': 1000.0},
        {'name': 'Desktops', 'quantity': 30, 'price': 800.0},
        {'name': 'Printers', 'quantity': 10, 'price': 200.0},
        {'name': 'Monitors', 'quantity': 15, 'price': 150.0},
        {'name': 'Routers', 'quantity': 25, 'price': 70.0},
      ]
    },
    {
      'name': 'Furniture',
      'code': 'FUR',
      'description': 'Office furniture and fittings',
      'budget': '2500000',
      'userInCharge': 'Michael Nyangumi',
      'items': [
        {'name': 'Chairs', 'quantity': 50, 'price': 50.0},
        {'name': 'Desks', 'quantity': 20, 'price': 100.0},
        {'name': 'Filing Cabinets', 'quantity': 15, 'price': 200.0},
        {'name': 'Conference Tables', 'quantity': 5, 'price': 500.0},
        {'name': 'Sofas', 'quantity': 10, 'price': 300.0},
      ]
    },
    {
      'name': 'Laboratory Equipment',
      'code': 'LAB',
      'description': 'Scientific laboratory apparatus and chemicals',
      'budget': '4500000',
      'userInCharge': 'Emma Nyakio',
      'items': [
        {'name': 'Microscopes', 'quantity': 10, 'price': 500.0},
        {'name': 'Test Tubes', 'quantity': 100, 'price': 10.0},
        {'name': 'Beakers', 'quantity': 50, 'price': 5.0},
        {'name': 'Petri Dishes', 'quantity': 200, 'price': 2.0},
        {'name': 'Bunsen Burners', 'quantity': 20, 'price': 30.0},
      ]
    },
    {
      'name': 'Books and Publications',
      'code': 'BP',
      'description': 'Academic books, journals and publications',
      'budget': '1200000',
      'userInCharge': 'Robert Mwangi',
      'items': [
        {'name': 'Textbooks', 'quantity': 50, 'price': 20.0},
        {'name': 'Journals', 'quantity': 20, 'price': 10.0},
        {'name': 'Research Papers', 'quantity': 15, 'price': 15.0},
        {'name': 'Magazines', 'quantity': 50, 'price': 5.0},
        {'name': 'E-books', 'quantity': 100, 'price': 0.99},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {}

  void scrollToIndex(int index) {
    if (index < 0 || index >= categories.length) return;

    final double itemHeight = 110;
    final double offset = index * itemHeight;

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
          IconButton(
            icon: const Icon(Icons.arrow_downward),
            onPressed: () {
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
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
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
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.amber),
                                  onPressed: () {
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
          FloatingActionButton(
            onPressed: () {
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

  String _formatCurrency(String amount) {
    final number = double.tryParse(amount) ?? 0;
    return number.toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}

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
  final ScrollController _detailsScrollController = ScrollController();
  bool _showItems = false;

  @override
  void dispose() {
    _detailsScrollController.dispose();
    super.dispose();
  }

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
              _buildSectionTitle("Category Information"),
              const SizedBox(height: 16),
              _buildInfoItem(context, "Description",
                  widget.category['description'], Icons.description),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showItems = !_showItems;
                  });
                },
                child: Text(
                  _showItems
                      ? "Hide Category Items (${widget.category['items'].length})"
                      : "Show Category Items (${widget.category['items'].length})",
                ),
              ),
              _showItems
                  ? Column(
                      children: widget.category['items'].map<Widget>((item) {
                        return ListTile(
                          title: Text(item['name']),
                          subtitle: Text('Quantity: ${item['quantity']}'),
                        );
                      }).toList(),
                    )
                  : const SizedBox(),
              const SizedBox(height: 40),
              _buildInfoItem(
                  context,
                  "User in Charge",
                  widget.category['userInCharge'],
                  Icons.supervised_user_circle),
              const SizedBox(height: 40),
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
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Additem(
                            categoryId: widget.category['code'],
                            categoryName: widget.category['name'],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text("Add Item"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
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
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollDown,
        mini: true,
        backgroundColor: Colors.grey[700],
        child: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }

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


