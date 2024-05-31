import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zemnanit/presentation/screens/create_user.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';
import 'package:zemnanit/presentation/screens/common_widgets/my_bottom_navigation.dart';

void main() {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'main',
        builder: (context, state) => MyHomePage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => Login(),
      ),
      GoRoute(
        path: '/createAccount',
        name: 'createAccount',
        builder: (context, state) => Create_user(),
      ),
    ],
  );

  runApp(ProviderScope(child: MyApp(router: router))); // Wrap with ProviderScope
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  MyApp({required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Zemnanit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1CFC3),
      appBar: AppBar(title: Text('Zemnanit')),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/zemnanit.jpg"),
              Positioned(
                top: 170,
                left: 80,
                child: RichText(
                  text: TextSpan(
                    text: "Welcome to ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Zemnanit",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 220,
                left: 140,
                child: Text(
                  "Beauty Salons!",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 60.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Color.fromARGB(255, 249, 245, 245),
            ),
            child: TextButton.icon(
              onPressed: () {
                context.go('/createAccount');
              },
              label: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: Icon(Icons.play_arrow, size: 30),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
