// lib/login_admin.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:admin_side/admin_dashboard.dart'; // Adjust this import according to your project structure
import 'package:admin_side/token_decoder.dart';

class AdminLoginPage extends StatefulWidget {
  final http.Client httpClient;

  AdminLoginPage({required this.httpClient});

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _loginAdmin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    final Map<String, String> requestData = {
      'email': email,
      'password': password,
    };

    final Uri uri = Uri.parse('http://[::1]:3000/users/login');

    try {
      final http.Response response = await widget.httpClient.post(
        uri,
        body: jsonEncode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic>? responseData = jsonDecode(response.body);
        final String? accessToken = responseData?['access_token'];

        if (accessToken != null) {
          final Map<String, dynamic> decodedToken =
              TokenDecoder.decodeToken(accessToken);
          final String? role = decodedToken['role'];

          if (role == 'Admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminDashboard(accessToken: accessToken),
              ),
            );
          } else {
            setState(() {
              _errorMessage =
                  'You are not authorized to access the admin panel.';
            });
          }
        } else {
          setState(() {
            _errorMessage = 'Invalid token received.';
          });
        }
      } else if (response.statusCode == 401) {
        setState(() {
          _errorMessage = 'Invalid email or password';
        });
      } else {
        setState(() {
          _errorMessage = 'An error occurred. Please try again later.';
        });
      }
    } catch (error) {
      print('Error logging in: $error');
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _loginAdmin,
              child: _isLoading ? CircularProgressIndicator() : Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
