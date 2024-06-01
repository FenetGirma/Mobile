import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  MyBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 0 ? Icons.home : Icons.home_outlined,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 1 ? Icons.person_add : Icons.person_add_alt_1_outlined,
          ),
          label: 'Create Account',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 2 ? Icons.login : Icons.login_outlined,
          ),
          label: 'Login',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.red[400],
      unselectedItemColor: Colors.black,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/createAccount');
            break;
          case 2:
            context.go('/login');
            break;
        }
        onItemTapped(index);
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}
