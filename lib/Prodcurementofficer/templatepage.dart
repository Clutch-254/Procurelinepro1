import 'package:flutter/material.dart';

class Templatepage extends StatefulWidget {
  const Templatepage({super.key});

  @override
  State<Templatepage> createState() => _TemplatepageState();
}

class _TemplatepageState extends State<Templatepage> {
  // Function to handle adding Excel files
  void _addExcelFile() {
    // Implement file picking functionality here
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Excel file picker would open here'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Template'),
        centerTitle: true, // Center the title in the AppBar
        backgroundColor: Colors.green, // Green background for the AppBar
        foregroundColor: Colors.white, // White text for better contrast
      ),
      body: Stack(
        children: [
          // Positioned add excel button below the AppBar at the right
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: _addExcelFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add Excel'),
            ),
          ),
          // Centered template container
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: Text(
                  'Template',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
