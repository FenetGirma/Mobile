import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_admin.dart';
import 'manage_users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AdminLoginPage(httpClient: http.Client()),
        '/admin_dashboard': (context) => AdminDash(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/manage_users') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ManageUsersPage(accessToken: args['accessToken']);
            },
          );
        }
        return null;
      },
    );
  }
}

class AdminDash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // You should pass the access token here when navigating
            Navigator.pushNamed(context, '/manage_users', arguments: {
              'accessToken':
                  'your_access_token_here', // replace with the actual token
            });
          },
          child: Text('Manage Users'),
        ),
      ),
    );
  }
}
