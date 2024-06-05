import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';

class ProfilePage extends StatelessWidget {
  final String email;

  ProfilePage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Profile(email: email),
    );
  }
}

class Profile extends ConsumerWidget {
  final String email;

  Profile({required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authServiceProvider.notifier);
    final authState = ref.watch(authServiceProvider);

    final TextEditingController passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email: $email'),
          SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'New Password'),
            obscureText: true,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              await authService.updatePassword(email, passwordController.text);
              if (authState.message != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(authState.message!),
                ));
              } else if (authState.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(authState.error!),
                ));
              }
            },
            child: Text('Update Password'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              await authService.deleteUser(email);
              if (authState.message != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(authState.message!),
                ));
                Navigator.of(context).pop(); // Go back to the previous screen
              } else if (authState.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(authState.error!),
                ));
              }
            },
            child: Text('Delete Account'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}