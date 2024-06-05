import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:zemnanit/presentation/screens/profile_page.dart';
import 'home.dart';
import 'salons.dart';
import 'appointments.dart';
import 'login_user.dart';
import 'profile_page.dart';
// import 'home_bf_login.dart';

void main() {
  runApp(ZemnanitApp());
}

class ZemnanitApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Home(),
      ),
      GoRoute(
        path: '/salons',
        builder: (context, state) => ZemnanitSalons(),
      ),
      GoRoute(
        path: '/appointments',
        builder: (context, state) => MyAppointments(),
      ),
      GoRoute(
        path: '/logout',
        builder: (context, state) => Login(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return ProfilePage(email:email);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Salon List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/salons');
        break;
      case 2:
        context.go('/appointments');
        break;
      case 3:
        context.go('/logout');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Salons',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Logout',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
