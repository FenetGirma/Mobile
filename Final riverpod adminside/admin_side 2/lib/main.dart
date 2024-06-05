import 'package:admin_side/screens/admin_dashboard.dart';
import 'package:admin_side/screens/manage_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'screens/login_admin.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zemnanit Beauty Salons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AdminLoginPage(httpClient: http.Client()),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/admin_dashboard') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return AdminDash(accessToken: args['accessToken']);
            },
          );
        } else if (settings.name == '/manage_users') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ManageUsersScreen(accessToken: args['accessToken']);
            },
          );
        }
        return null;
      },
    );
  }
}
