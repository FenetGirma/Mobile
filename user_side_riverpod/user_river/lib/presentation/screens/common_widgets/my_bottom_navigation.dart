// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../auth_service.dart';

// // Define a StateProvider for the selected index of the BottomNavigationBar
// final selectedIndexProvider = StateProvider<int>((ref) => 0);

// class MyBottomNavigationBar extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = ref.watch(selectedIndexProvider);

//     return BottomNavigationBar(
//       items: <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(
//             selectedIndex == 0 ? Icons.home : Icons.home_outlined,
//           ),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             selectedIndex == 1 ? Icons.person_add : Icons.person_add_alt_1_outlined,
//           ),
//           label: 'Create Account',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             selectedIndex == 2 ? Icons.login : Icons.login_outlined,
//           ),
//           label: 'Login',
//         ),
//       ],
//       currentIndex: selectedIndex,
//       selectedItemColor: Colors.red[400],
//       unselectedItemColor: Colors.black,
//       onTap: (index) {
//         final authService = ref.read(authServiceProvider.notifier);

//         switch (index) {
//           case 0:
//             Navigator.pushReplacementNamed(context, '/home_bf_login');
//             break;
//           case 1:
//             Navigator.pushReplacementNamed(context, '/createaccount');
//             break;
//           case 2:
//             Navigator.pushReplacementNamed(context, '/login');
//             break;
//         }
//         ref.read(selectedIndexProvider.notifier).state = index;
//       },
//       showSelectedLabels: true,
//       showUnselectedLabels: true,
//     );
//   }
// }
