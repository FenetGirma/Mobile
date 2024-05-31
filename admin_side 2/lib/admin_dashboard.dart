// admin_dashboard.dart
import 'package:admin_side/salon_list_screen.dart';
import 'package:flutter/material.dart';
import 'manage_users.dart';
import 'add_salon_screen.dart';
import 'salon_list_screen.dart'; // Import the salon list page

class AdminDashboard extends StatelessWidget {
  final String accessToken;

  AdminDashboard({required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ManageUsersPage(accessToken: accessToken),
                  ),
                );
              },
              child: Text('Manage Users'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddSalonScreen(accessToken: accessToken),
                  ),
                );
              },
              child: Text('Add Salon'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SalonListScreen(accessToken: accessToken),
                  ),
                );
              },
              child:
                  Text('View Salons'), // Button to navigate to salon list page
            ),
          ],
        ),
      ),
    );
  }
}
