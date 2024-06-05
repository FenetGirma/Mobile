import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/testing.dart';
import 'add_salon_screen.dart';
import 'manage_users.dart';
import 'salon_list_screen.dart';

class AdminDash extends StatefulWidget {
  final String accessToken;

  AdminDash({required this.accessToken});

  @override
  _AdminDashState createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      AddSalonScreen(accessToken: widget.accessToken),
      SalonListScreen(
        accessToken: widget.accessToken,
      ),
      ManageUsersScreen(accessToken: widget.accessToken),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zemnanit Beauty Salons'),
        backgroundColor: Colors.red[200],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Salon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'View Salons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Manage Users',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
