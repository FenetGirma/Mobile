// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
// import 'package:zemnanit/presentation/screens/common_widgets/my_bottom_navigation.dart';
// import 'package:zemnanit/presentation/screens/login_user.dart';
// import 'create_user.dart';
// import 'auth_service.dart';
// import 'profile_page.dart';

// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Zemnanit',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       routes: {
//         '/home_bf_login': (context) => Home_before(),
//         '/createaccount': (context) => Create_user(),
//         '/login': (context) => Login(),
//       },
//       home: AppLayout()
//     );
//   }
// }

// class AppLayout extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = ref.watch(selectedIndexProvider);
//     Widget getPage() {
//       switch (selectedIndex) {
//         case 0:
//           return Home_before();
//         case 1:
//           return Create_user();
//         case 2:
//           return Login();
//         default:
//           return Home_before();
//       }
//     }

//     return Scaffold(
//       body: getPage(),
//     );
//   }
// }

// class Home_before extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<Home_before> createState() => _HomeState();
// }

// class _HomeState extends ConsumerState<Home_before> {
//   @override
//   Widget build(BuildContext context) {
//     final selectedIndex = ref.watch(selectedIndexProvider);
//     final authState = ref.watch(authServiceProvider);

//     return Scaffold(
//       backgroundColor: Color(0xFFF1CFC3),
//       appBar: MyAppBar(),
//       bottomNavigationBar: MyBottomNavigationBar(),
//       body: Container(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Image(
//                   image: AssetImage("assets/zemnanit.jpg"),
//                 ),
//                 Positioned(
//                   top: 170,
//                   left: 80,
//                   child: RichText(
//                     text: TextSpan(
//                       text: "Welcome to ",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 35,
//                         fontWeight: FontWeight.bold
//                       ),
//                       children: [
//                         TextSpan(
//                           text: "Zemnanit",
//                           style: TextStyle(
//                             color: Colors.pink,
//                             fontSize: 36,
//                             fontWeight: FontWeight.bold
//                           )
//                         )
//                       ]
//                     )
//                   )
//                 ),
//                 Positioned(
//                   top: 220,
//                   left: 140,
//                   child: Text(
//                     "Beauty Salons!",
//                     style: TextStyle(
//                       fontSize: 35,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 60.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
