// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:zemnanit/presentation/screens/appointments.dart';
// // import 'package:zemnanit/presentation/screens/common_widgets/bottomnav.dart';
// // import 'package:zemnanit/presentation/screens/home.dart';
// // import 'package:zemnanit/presentation/screens/login_user.dart';
// // import 'package:zemnanit/presentation/screens/salonss.dart';
// // import 'auth_service.dart';

// // void main() {
// //   runApp(ZemnanitApp());
// // }

// // class ZemnanitApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ProviderScope(
// //       child: MaterialApp(
// //         title: 'Salon List App',
// //         theme: ThemeData(
// //           primarySwatch: Colors.blue,
// //         ),
// //         routes: {
// //           '/home': (context) => Home(
// //                 email: '',
// //               ),
// //           '/salons': (context) => SalonListScreen(),
// //           '/appointments': (context) => MyAppointments(),
// //           '/logout': (context) => Login(),
// //           '/book': (context) => ZemnanitDrop(),
// //         },
// //         home: Login(),
// //       ),
// //     );
// //   }
// // }

// // class Login extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: Log_in(),
// //     );
// //   }
// // }

// // class Log_in extends ConsumerStatefulWidget {
// //   const Log_in({Key? key}) : super(key: key);

// //   @override
// //   ConsumerState<Log_in> createState() => _LoginState();
// // }

// // class _LoginState extends ConsumerState<Log_in> {
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     ref.listen<AuthState>(authServiceProvider, (previous, next) {
// //       if (next.accessToken != null) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text(
// //                 'Access Token: ${next.accessToken}\nEmail: ${emailController.text.trim()}'),
// //           ),
// //         );
// //         Navigator.of(context).pushReplacement(
// //           MaterialPageRoute(
// //               builder: (context) => Home(email: emailController.text.trim())),
// //         );
// //       }
// //       if (next.error != null) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text(next.error!)),
// //         );
// //       }
// //     });

// //     final authState = ref.watch(authServiceProvider);
// //     final authNotifier = ref.read(authServiceProvider.notifier);

// //     return Scaffold(
// //       backgroundColor: Color(0xFFF1CFC3),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               'Zemnanit Beauty Salons',
// //               style: TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.red[400]),
// //             ),
// //             SizedBox(height: 10),
// //             Text('Welcome User!',
// //                 style: TextStyle(fontWeight: FontWeight.bold)),
// //             SizedBox(height: 25),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 20),
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   border: Border.all(color: Colors.white),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(left: 20.0),
// //                   child: TextField(
// //                     controller: emailController,
// //                     decoration: InputDecoration(
// //                       border: InputBorder.none,
// //                       hintText: 'Email',
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 20),
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   border: Border.all(color: Colors.white),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(left: 20.0),
// //                   child: TextField(
// //                     controller: passwordController,
// //                     obscureText: true,
// //                     decoration: InputDecoration(
// //                       border: InputBorder.none,
// //                       hintText: 'Password',
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 20.0),
// //               child: GestureDetector(
// //                 onTap: () async {
// //                   await authNotifier.login(
// //                     emailController.text.trim(),
// //                     passwordController.text.trim(),
// //                   );
// //                 },
// //                 child: Container(
// //                   padding: EdgeInsets.all(20),
// //                   decoration: BoxDecoration(
// //                     color: Colors.red[400],
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child: Center(
// //                     child: authState.loading
// //                         ? CircularProgressIndicator(
// //                             valueColor:
// //                                 AlwaysStoppedAnimation<Color>(Colors.white),
// //                           )
// //                         : Text(
// //                             'Sign In',
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 18,
// //                             ),
// //                           ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class ZemnanitDrop extends ConsumerStatefulWidget {
// //   @override
// //   ConsumerState<ZemnanitDrop> createState() => _BookingPageState();
// // }

// // class _BookingPageState extends ConsumerState<ZemnanitDrop> {
// //   final TextEditingController fullnameController = TextEditingController();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController commentController = TextEditingController();
// //   DateTime selectedDate = DateTime.now();
// //   String selectedStyle = 'Shuruba';
// //   String selectedTime = '1PM';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Book a Salon'),
// //         backgroundColor: Color(0xE6FFFFFF),
// //       ),
// //       backgroundColor: Color(0xFFF1CFC3),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               _buildTextField(
// //                   fullnameController, 'Full Name', 'Enter your full name'),
// //               SizedBox(height: 10),
// //               _buildTextField(emailController, 'Email', 'Enter your email'),
// //               SizedBox(height: 10),
// //               _buildDropdown('Choose a hair style', selectedStyle,
// //                   ['Shuruba', 'Kutirtir', 'Publis'], (newStyle) {
// //                 setState(() {
// //                   selectedStyle = newStyle!;
// //                 });
// //               }),
// //               SizedBox(height: 10),
// //               _buildDropdown('Select Time', selectedTime, [
// //                 '1PM',
// //                 '2PM',
// //                 '3PM',
// //                 '4PM',
// //                 '5PM',
// //                 '6PM',
// //                 '7PM',
// //                 '9PM',
// //                 '10PM',
// //                 '11PM'
// //               ], (newTime) {
// //                 setState(() {
// //                   selectedTime = newTime!;
// //                 });
// //               }),
// //               SizedBox(height: 10),
// //               _buildDatePicker(context),
// //               SizedBox(height: 10),
// //               _buildTextField(commentController, 'Comments',
// //                   'Provide any specific instruction or additional comment'),
// //               SizedBox(height: 20),
// //               _buildSubmitButton(context),
// //             ],
// //           ),
// //         ),
// //       ),
// //       bottomNavigationBar: MyBottomNavigationBar(),
// //     );
// //   }

// //   Widget _buildTextField(
// //       TextEditingController controller, String labelText, String hintText) {
// //     return TextField(
// //       controller: controller,
// //       decoration: InputDecoration(
// //         labelText: labelText,
// //         hintText: hintText,
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(15.0),
// //         ),
// //         filled: true,
// //         fillColor: Colors.white,
// //       ),
// //     );
// //   }

// //   Widget _buildDropdown(String label, String value, List<String> items,
// //       ValueChanged<String?> onChanged) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           label,
// //           style: TextStyle(fontSize: 16),
// //         ),
// //         DropdownButton<String>(
// //           value: value,
// //           onChanged: onChanged,
// //           items: items
// //               .map((value) => DropdownMenuItem<String>(
// //                     value: value,
// //                     child: Text(value),
// //                   ))
// //               .toList(),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildDatePicker(BuildContext context) {
// //     return Row(
// //       children: [
// //         Text(
// //           'Select a date:',
// //           style: TextStyle(fontSize: 16),
// //         ),
// //         Spacer(),
// //         ElevatedButton(
// //           onPressed: () async {
// //             DateTime? picked = await showDatePicker(
// //               context: context,
// //               initialDate: selectedDate,
// //               firstDate: DateTime(2000),
// //               lastDate: DateTime(2101),
// //             );
// //             if (picked != null && picked != selectedDate) {
// //               setState(() {
// //                 selectedDate = picked;
// //               });
// //             }
// //           },
// //           child: Text(
// //             '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
// //             style: TextStyle(fontSize: 16),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildSubmitButton(BuildContext context) {
// //     return ElevatedButton(
// //       onPressed: () {
// //         final fullName = fullnameController.text;
// //         final email = emailController.text;
// //         final hairStyle = selectedStyle;
// //         final date =
// //             '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
// //         final time = selectedTime;
// //         final comment = commentController.text;

// //         ref.read(authServiceProvider.notifier).bookSalon(
// //               fullName,
// //               email,
// //               hairStyle,
// //               date,
// //               time,
// //               comment,
// //             );

// //         showDialog(
// //           context: context,
// //           builder: (BuildContext context) {
// //             return AlertDialog(
// //               title: Text('Booking Confirmed'),
// //               content: Text('Your booking has been successfully submitted.'),
// //               actions: <Widget>[
// //                 TextButton(
// //                   child: Text('OK'),
// //                   onPressed: () {
// //                     Navigator.of(context).pop();
// //                     _clearForm();
// //                   },
// //                 ),
// //               ],
// //             );
// //           },
// //         );
// //       },
// //       child: Text('Book'),
// //       style: ElevatedButton.styleFrom(
// //         foregroundColor: Colors.white,
// //         backgroundColor: Colors.black54,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(15.0),
// //         ),
// //       ),
// //     );
// //   }

// //   void _clearForm() {
// //     fullnameController.clear();
// //     emailController.clear();
// //     commentController.clear();
// //     setState(() {
// //       selectedDate = DateTime.now();
// //       selectedStyle = 'Shuruba';
// //       selectedTime = '1PM';
// //     });
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'home.dart';
// import 'salons.dart';
// import 'appointments.dart';
// import 'home_bf_login.dart';

// void main() {
//   runApp(ZemnanitApp());
// }

// class ZemnanitApp extends StatelessWidget {
//   final GoRouter _router = GoRouter(
//     initialLocation: '/',
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) => Home(),
//       ),
//       GoRoute(
//         path: '/salons',
//         builder: (context, state) => SalonListScreen(),
//       ),
//       GoRoute(
//         path: '/appointments',
//         builder: (context, state) => MyAppointments(),
//       ),
//       GoRoute(
//         path: '/logout',
//         builder: (context, state) => Login(),
//       ),
//     ],
//   );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: _router,
//       title: 'Salon List App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//     );
//   }
// }

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: Text(
//           'Home Page',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//       bottomNavigationBar: MyBottomNavigationBar(),
//     );
//   }
// }

// class MyBottomNavigationBar extends StatefulWidget {
//   @override
//   _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
// }

// class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     switch (index) {
//       case 0:
//         context.go('/');
//         break;
//       case 1:
//         context.go('/salons');
//         break;
//       case 2:
//         context.go('/appointments');
//         break;
//       case 3:
//         context.go('/logout');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.store),
//           label: 'Salons',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.calendar_today),
//           label: 'Appointments',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.logout),
//           label: 'Logout',
//         ),
//       ],
//       currentIndex: _selectedIndex,
//       selectedItemColor: Colors.amber[800],
//       onTap: _onItemTapped,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zemnanit/presentation/screens/auth_service.dart';
import 'package:zemnanit/presentation/screens/common_widgets/bottomnav.dart';
import 'package:zemnanit/presentation/screens/home_bf_login.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';
import 'package:zemnanit/presentation/screens/appointments.dart';
import 'package:zemnanit/presentation/screens/booking.dart';
import 'package:zemnanit/presentation/screens/home.dart';
import 'package:zemnanit/presentation/screens/salonss.dart';

void main() {
  runApp(ProviderScope(child: ZemnanitApp()));
}

class ZemnanitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salon List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => Home(email: ''),
        '/salons': (context) => SalonListScreen(),
        '/appointments': (context) => MyAppointments(),
        '/logout': (context) => Login(),
        '/login': (context) => Login(),
        '/book': (context) => ZemnanitDrop(),
      },
      home: AppLayout(),
    );
  }
}

class AppLayout extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    Widget getPage() {
      switch (selectedIndex) {
        case 0:
          return Home(email: '');
        case 1:
          return SalonListScreen();
        case 2:
          return MyAppointments();
        case 3:
          return Login();
        default:
          return Login();
      }
    }

    return Scaffold(
      // appBar: AppBar(title: Text('Salon List App')),
      body: getPage(),
      // bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
