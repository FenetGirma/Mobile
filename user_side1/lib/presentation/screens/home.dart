import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
import 'package:zemnanit/presentation/screens/common_widgets/bottomnav.dart' as bottomnav; // Import the bottom navigation bar
import 'appointments.dart';
import 'salonss.dart';
import 'login_user.dart'; // Import your Login screen
import 'auth_service.dart';
import 'main.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zemnanit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => Home(),
        '/salons': (context) => ZemnanitApp(),
        '/appointments': (context) => MyAppointments(),
        '/logout': (context) => MyApp(),
      },
      home: Consumer(
        builder: (context, ref, child) {
          final authState = ref.watch(authServiceProvider);
          if (authState.access_token == null) {
            return Login();
          } else {
            return Home();
          }
        },
      ),
    );
  }
}

class Home extends ConsumerStatefulWidget {
  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(bottomnav.selectedIndexProvider);
    final authState = ref.watch(authServiceProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF1CFC3),
      appBar: MyAppBar(),
      bottomNavigationBar: bottomnav.MyBottomNavigationBar(),
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
            // Center(
            //   child: Text('Welcome, ${authState.access_token}!'),
            // ),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color.fromARGB(255, 249, 245, 245),
              ),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZemnanitApp(), // Navigate to the second page
                    ),
                  );
                },
                label: Text(
                  "Get Started",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold),
                ),
                icon: Icon(
                  Icons.play_arrow,
                  size: 30,
                ),
              ),
            ),
            // SizedBox(height: 20.0),
            // authState.access_token != null
            //     ? Text(
            //         "Hi, ${authState.access_token}!",
            //         style: TextStyle(
            //           fontSize: 25,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black,
            //         ),
            //       )
            //     : CircularProgressIndicator(),
          ],
        ),
      ),
      
    );
  }
}

