// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'auth_service.dart';
// import 'home.dart';


// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Login(),
//     );
//   }
// }
// class Login extends ConsumerStatefulWidget {
//   const Login({super.key});

//   @override
//   ConsumerState<Login> createState() => _LoginState();
// }

// class _LoginState extends ConsumerState<Login> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final authState = ref.watch(authServiceProvider);
//     final authNotifier = ref.read(authServiceProvider.notifier);

//     return Scaffold(
//       backgroundColor: Color(0xFFF1CFC3),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Zemnanit Beauty Salons',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red[400]),
//             ),
//             SizedBox(height: 10),
//             Text('Welcome User!',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             SizedBox(height: 25),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                       labelText: 'Enter Email',
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.all(10),
//                       prefixIcon: Icon(Icons.person, color: Colors.grey[600])),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextField(
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Enter Password',
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.all(10),
//                     prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
//                   ),
//                   obscureText: true,
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),
//          ElevatedButton(
//                     onPressed: () async {
//                       await authNotifier.login(
//                         emailController.text,
//                         passwordController.text,
//                       );
//                       if (authState.access_token != null) {
//                         Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(builder: (context) => Home()),
//                         );
//                       }
//                     },
//                     child: Text('Login'),
//                   ),
//             if (authState.error != null) ...[
//               SizedBox(height: 20),
//               Text(authState.error!, style: TextStyle(color: Colors.red)),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';
import 'home.dart';

void main() {
  runApp(ProviderScope(child: Login()));
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Log_in(),
    );
  }
}

class Log_in extends ConsumerStatefulWidget {
  const Log_in({Key? key}) : super(key: key);

  @override
  ConsumerState<Log_in> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Log_in> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authServiceProvider, (previous, next) {
      if (next.access_token != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    final authState = ref.watch(authServiceProvider);
    final authNotifier = ref.read(authServiceProvider.notifier);

    return Scaffold(
      backgroundColor: Color(0xFFF1CFC3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Zemnanit Beauty Salons',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[400]),
            ),
            SizedBox(height: 10),
            Text('Welcome User!',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Enter Email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(Icons.person, color: Colors.grey[600])),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                  ),
                  obscureText: true,
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await authNotifier.login(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Login'),
            ),
            if (authState.error != null) ...[
              SizedBox(height: 20),
              Text(authState.error!, style: TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}