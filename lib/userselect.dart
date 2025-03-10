import 'package:flutter/material.dart';
import 'package:procurelineapp/Departmentaluser.dart';
import 'package:procurelineapp/procurementofficer.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First button - Procurement Officer
            Container(
              width: 250,
              height: 60,
              margin: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Procurement Officer page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Procurementofficer(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "Procurement Officer",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Second button - Departmental User
            Container(
              width: 250,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Departmental User page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Departmentaluser(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "Departmental User",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
