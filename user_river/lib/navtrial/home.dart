import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
import 'appointments.dart';
import 'main.dart';
import 'salons.dart';
import 'login_user.dart';
import 'auth_service.dart';
import 'profile_page.dart'; // Import your ProfilePage screen

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            final authState = ref.watch(authServiceProvider);
            if (authState.accessToken == null) {
              return Login();
            } else {
              final email = authState.email ?? '';
              return Home(email: email);
            }
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => ProfilePage(email: '')
        ),
        // Add other routes here...
      ],
    );

    return MaterialApp.router(
      routerConfig: _router,
      title: 'Zemnanit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class Home extends ConsumerStatefulWidget {
  final String email;

  Home({required this.email});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authServiceProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF1CFC3),
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Image(
                  image: AssetImage("assets/zemnanit.jpg"),
                ),
                Positioned(
                    top: 170,
                    left: 80,
                    child: RichText(
                        text: TextSpan(
                            text: "Welcome to ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: "Zemnanit",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold))
                        ]))),
                Positioned(
                  top: 220,
                  left: 140,
                  child: Text(
                    "Beauty Salons!",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60.0,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color.fromARGB(255, 249, 245, 245),
              ),
              child: TextButton.icon(
                onPressed: () {
                  context.push('/profile', extra: widget.email);
                },
                label: Text(
                  "Go to Profile",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold),
                ),
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}