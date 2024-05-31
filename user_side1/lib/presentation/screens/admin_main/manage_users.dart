import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageUsersPage extends StatefulWidget {
  final String accessToken;

  ManageUsersPage({required this.accessToken});

  @override
  _ManageUsersPageState createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
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

    try {
      final http.Response response = await http.get(
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
      } else if (response.statusCode == 204) {
        setState(() {
          _users = [];
          _isLoading = false;
        });
      } else if (response.statusCode == 401) {
        setState(() {
          _errorMessage = 'Unauthorized access. Please log in again.';
          _isLoading = false;
        });
      } else if (response.statusCode == 403) {
        setState(() {
          _errorMessage =
              'Forbidden. You do not have permission to view this data.';
          _isLoading = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = 'Users not found.';
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load users';
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching users: $error');
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserRole(String email, String newRole) async {
    final Uri uri = Uri.parse('http://[::1]:3000/users/update-role');

    try {
      final http.Response response = await http.patch(
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
      } else if (response.statusCode == 204) {
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
      } else if (response.statusCode == 400) {
        setState(() {
          _errorMessage = 'Bad request. Please check the data and try again.';
        });
      } else if (response.statusCode == 401) {
        setState(() {
          _errorMessage = 'Unauthorized access. Please log in again.';
        });
      } else if (response.statusCode == 403) {
        setState(() {
          _errorMessage =
              'Forbidden. You do not have permission to update this user.';
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = 'User not found.';
        });
      } else {
        print('Unexpected status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _errorMessage = 'Failed to update user role';
        });
      }
    } catch (error) {
      print('Error updating user role: $error');
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
                        trailing: DropdownButton<String>(
                          value: selectedRole,
                          onChanged: (newRole) {
                            if (newRole != null) {
                              setState(() {
                                _selectedRoles[index] = newRole;
                              });
                              _updateUserRole(user['email'], newRole);
                            }
                          },
                          items: ['admin', 'user']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
