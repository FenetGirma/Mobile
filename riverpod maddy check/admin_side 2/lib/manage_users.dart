// lib/manage_users.dart
// lib/manage_users.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token_decoder.dart';

class ManageUsersPage extends StatefulWidget {
  final String accessToken;

  ManageUsersPage({required this.accessToken});

  @override
  _ManageUsersPageState createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  final http.Client httpClient = http.Client();
  bool _isLoading = true;
  String _errorMessage = '';
  List<dynamic> _users = [];
  Map<int, String> _selectedRoles = {};

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final Uri uri = Uri.parse('http://[::1]:3000/users');
    final decodedToken = TokenDecoder.decodeToken(widget.accessToken);

    try {
      final http.Response response = await httpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _users = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load users';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserRole(String email, String newRole) async {
    final Uri uri = Uri.parse('http://[::1]:3000/users/update-role');

    try {
      final http.Response response = await httpClient.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.accessToken}',
        },
        body: jsonEncode({'email': email, 'role': newRole}),
      );

      if (response.statusCode == 200) {
        setState(() {
          final index = _users.indexWhere((user) => user['email'] == email);
          if (index != -1) {
            _users[index]['role'] = newRole;
            _selectedRoles[index] = newRole;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Role updated for $email to $newRole'),
        ));
      } else {
        setState(() {
          _errorMessage = 'Failed to update user role';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(_errorMessage, style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    final selectedRole = _selectedRoles[index] ?? user['role'];
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(user['email']),
                        subtitle: Text('Role: $selectedRole'),
                        trailing: PopupMenuButton<String>(
                          onSelected: (newRole) {
                            setState(() {
                              _selectedRoles[index] = newRole;
                            });
                            _updateUserRole(user['email'], newRole);
                          },
                          itemBuilder: (context) => ['admin', 'user']
                              .map((role) => PopupMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ))
                              .toList(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(selectedRole),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
