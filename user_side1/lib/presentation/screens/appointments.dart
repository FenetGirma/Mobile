// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:zemnanit/presentation/screens/login_user.dart';
// // import 'auth_service.dart';
// // import 'home.dart';
// // import 'main.dart';
// // import 'salons.dart';
// // import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
// // import 'package:zemnanit/presentation/screens/common_widgets/bottomnav.dart';

// // class MyAppointments extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'My Appointments',
// //       theme: ThemeData(primarySwatch: Colors.blue),
// //       home: _MyAppointments(),
// //       routes: {
// //         '/home': (context) => Home(),
// //         '/salons': (context) => ZemnanitApp(),
// //         '/appointments': (context) => MyAppointments(),
// //         '/logout': (context) => Login(),
// //       },
// //     );
// //   }
// // }

// // class _MyAppointments extends ConsumerStatefulWidget {
// //   @override
// //   ConsumerState<_MyAppointments> createState() => __MyAppointmentsState();
// // }

// // class __MyAppointmentsState extends ConsumerState<_MyAppointments> {
// //   @override
// //   // void initState() {
// //   //   super.initState();
// //   //   _fetchAppointments();
// //   // }

// //   // Future<void> _fetchAppointments() async {
// //   //   final authService = ref.read(authServiceProvider.notifier);
// //   //   final email = ref.read(authServiceProvider).email;

// //   //   if (email != null) {
// //   //     await authService.fetchAppointments();
// //   //   } else {
// //   //     // Handle the case where email is not available
// //   //     print("Error: Email is not available.");
// //   //   }
// //   // }

  

// //   @override
// //   Widget build(BuildContext context) {
// //     final authState = ref.watch(authServiceProvider);

// //     return Scaffold(
// //       appBar: MyAppBar(),
// //       bottomNavigationBar: MyBottomNavigationBar(),
// //       body: Center(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 20.0),
// //           child: Column(
// //             children: [
// //               Text(
// //                 'My Appointments',
// //                 style: TextStyle(
// //                   color: Colors.red[400],
// //                   fontSize: 20.0,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               SizedBox(height: 10.0),
// //               authState.appointments != null
// //                   ? Expanded(
// //                       child: ListView.builder(
// //                         itemCount: authState.appointments!.length,
// //                         itemBuilder: (context, index) {
// //                           final booking = authState.appointments![index];
// //                           return Padding(
// //                             padding: const EdgeInsets.all(10.0),
// //                             child: ClipRRect(
// //                               borderRadius: BorderRadius.circular(10.0),
// //                               child: Container(
// //                                 padding: EdgeInsets.all(20),
// //                                 color: Colors.deepOrange[100],
// //                                 child: Row(
// //                                   children: [
// //                                     Container(
// //                                       height: 140,
// //                                       width: 100,
// //                                       child: booking['image'] != null
// //                                           ? Image.network(
// //                                               booking['image'],
// //                                               fit: BoxFit.cover,
// //                                             )
// //                                           : Icon(Icons.image),
// //                                     ),
// //                                     SizedBox(width: 20),
// //                                     Column(
// //                                       crossAxisAlignment: CrossAxisAlignment.start,
// //                                       children: [
// //                                         Text(
// //                                           booking['salonName'] ?? 'No salon name',
// //                                           style: TextStyle(
// //                                             color: Colors.black,
// //                                             fontSize: 20,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                         ),
// //                                         Row(
// //                                           children: [
// //                                             Icon(Icons.location_on, color: Colors.red[400]),
// //                                             Text(
// //                                               booking['location'] ?? 'No location',
// //                                               style: TextStyle(
// //                                                 fontWeight: FontWeight.bold,
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                         Text(
// //                                           booking['hairStyle'] ?? 'No style',
// //                                           style: TextStyle(
// //                                             color: Colors.black,
// //                                             fontSize: 15,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                         ),
// //                                         Text(booking['date'] ?? 'No date'),
// //                                         Text(booking['time'] ?? 'No time'),
// //                                         Text(booking['comment'] ?? 'No comment'),
// //                                         SizedBox(height: 20),
// //                                         Row(
// //                                           children: [
// //                                             ElevatedButton(
// //                                               onPressed: () async {
// //                                                 // Implement edit functionality here
// //                                                 // Show a dialog to edit the appointment details
// //                                                 final newFullName = booking['fullName'];
// //                                                 final newEmail = booking['email'];
// //                                                 final newHairStyle = booking['hairStyle'];
// //                                                 final newDate = booking['date'];
// //                                                 final newTime = booking['time'];
// //                                                 final newComment = booking['comment'];

// //                                                 // For simplicity, using the existing details without modification
// //                                                 await editAppointment(
// //                                                   booking['_id'],
// //                                                   newFullName,
// //                                                   newEmail,
// //                                                   newHairStyle,
// //                                                   newDate,
// //                                                   newTime,
// //                                                   newComment,
// //                                                 );
// //                                               },
// //                                               style: ElevatedButton.styleFrom(
// //                                                 foregroundColor: Colors.red[400],
// //                                                 backgroundColor: Colors.white,
// //                                               ),
// //                                               child: Text('Edit'),
// //                                             ),
// //                                             SizedBox(width: 10.0),
// //                                             ElevatedButton(
// //                                               onPressed: () async {
// //                                                 // Implement delete functionality here
// //                                                 await deleteAppointment(booking['_id']);
// //                                               },
// //                                               style: ElevatedButton.styleFrom(
// //                                                 foregroundColor: Colors.red[400],
// //                                                 backgroundColor: Colors.white,
// //                                               ),
// //                                               child: Text('Delete'),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       ),
// //                     )
// //                   : authState.error != null
// //                       ? Text(
// //                           'Error: ${authState.error}',
// //                           style: TextStyle(color: Colors.red),
// //                         )
// //                       : CircularProgressIndicator(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }











// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:zemnanit/presentation/screens/login_user.dart';
// // import 'auth_service.dart';
// // import 'home.dart';
// // import 'main.dart';
// // import 'salons.dart';
// // import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
// // import 'package:zemnanit/presentation/screens/common_widgets/bottomnav.dart';


// // class MyAppointments extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'My Appointments',
// //       theme: ThemeData(primarySwatch: Colors.blue),
// //       home: _MyAppointments(),
// //       routes: {
// //         '/home': (context) => Home(),
// //         '/salons': (context) => ZemnanitApp(),
// //         '/appointments': (context) => MyAppointments(),
// //         '/logout': (context) => Login(),
// //       },
// //     );
// //   }
// // }

// // class _MyAppointments extends ConsumerStatefulWidget {
// //   @override
// //   ConsumerState<_MyAppointments> createState() => __MyAppointmentsState();
// // }

// // class __MyAppointmentsState extends ConsumerState<_MyAppointments> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchAppointments();
// //   }

// //   Future<void> _fetchAppointments() async {
// //     final authService = ref.read(authServiceProvider.notifier);
// //     await authService.fetchAppointments();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final authState = ref.watch(authServiceProvider);

// //     return Scaffold(
// //       appBar: MyAppBar(),
// //       bottomNavigationBar: MyBottomNavigationBar(),
// //       body: Center(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 20.0),
// //           child: Column(
// //             children: [
// //               Text(
// //                 'My Appointments',
// //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //               ),
// //               authState.error != null
// //                   ? Text(
// //                       'Error: ${authState.error}',
// //                       style: TextStyle(color: Colors.red),
// //                     )
// //                   : authState.appointments == null
// //                       ? CircularProgressIndicator()
// //                       : Expanded(
// //                           child: ListView.builder(
// //                             itemCount: authState.appointments!.length,
// //                             itemBuilder: (context, index) {
// //                               final appointment =
// //                                   authState.appointments![index];
// //                               return ListTile(
// //                                 title: Text(appointment['hairStyle']),
// //                                 subtitle: Text(
// //                                     '${appointment['date']} at ${appointment['time']}'),
// //                                 trailing: Row(
// //                                   mainAxisSize: MainAxisSize.min,
// //                                   children: [
// //                                     IconButton(
// //                                       icon: Icon(Icons.edit),
// //                                       onPressed: () {
// //                                         _editAppointmentDialog(
// //                                             context, appointment);
// //                                       },
// //                                     ),
// //                                     IconButton(
// //                                       icon: Icon(Icons.delete),
// //                                       onPressed: () {
// //                                         _deleteAppointment(
// //                                             appointment['id']);
// //                                       },
// //                                     ),
// //                                   ],
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _deleteAppointment(String id) async {
// //     final authService = ref.read(authServiceProvider.notifier);
// //     await authService.deleteAppointment(id);
// //     _fetchAppointments();
// //   }

// //   Future<void> _editAppointment(
// //       String id,
// //       String fullName,
// //       String email,
// //       String hairStyle,
// //       String date,
// //       String time,
// //       String comment) async {
// //     final authService = ref.read(authServiceProvider.notifier);
// //     await authService.editAppointment(
// //         id, fullName, email, hairStyle, date, time, comment);
// //     _fetchAppointments();
// //   }

// //   void _editAppointmentDialog(BuildContext context, Map appointment) {
// //     final fullNameController =
// //         TextEditingController(text: appointment['fullName']);
// //     final emailController = TextEditingController(text: appointment['email']);
// //     final hairStyleController =
// //         TextEditingController(text: appointment['hairStyle']);
// //     final dateController = TextEditingController(text: appointment['date']);
// //     final timeController = TextEditingController(text: appointment['time']);
// //     final commentController =
// //         TextEditingController(text: appointment['comment']);

// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text('Edit Appointment'),
// //         content: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               TextField(
// //                 controller: fullNameController,
// //                 decoration: InputDecoration(labelText: 'Full Name'),
// //               ),
// //               TextField(
// //                 controller: emailController,
// //                 decoration: InputDecoration(labelText: 'Email'),
// //               ),
// //               TextField(
// //                 controller: hairStyleController,
// //                 decoration: InputDecoration(labelText: 'Hair Style'),
// //               ),
// //               TextField(
// //                 controller: dateController,
// //                 decoration: InputDecoration(labelText: 'Date'),
// //               ),
// //               TextField(
// //                 controller: timeController,
// //                 decoration: InputDecoration(labelText: 'Time'),
// //               ),
// //               TextField(
// //                 controller: commentController,
// //                 decoration: InputDecoration(labelText: 'Comment'),
// //               ),
// //             ],
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.of(context).pop();
// //             },
// //             child: Text('Cancel'),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               _editAppointment(
// //                 appointment['id'],
// //                 fullNameController.text,
// //                 emailController.text,
// //                 hairStyleController.text,
// //                 dateController.text,
// //                 timeController.text,
// //                 commentController.text,
// //               );
// //               Navigator.of(context).pop();
// //             },
// //             child: Text('Save'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:zemnanit/presentation/screens/login_user.dart';
// import 'auth_service.dart';
// import 'home.dart';
// import 'main.dart';
// import 'salonss.dart';
// import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
// import 'package:zemnanit/presentation/screens/common_widgets/bottomnav.dart';


// class MyAppointments extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My Appointments',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: _MyAppointments(),
//       routes: {
//         '/home': (context) => Home(),
//         '/salons': (context) => ZemnanitApp(),
//         '/appointments': (context) => MyAppointments(),
//         '/logout': (context) => Login(),
//       },
//     );
//   }
// }

// class _MyAppointments extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<_MyAppointments> createState() => __MyAppointmentsState();
// }

// class __MyAppointmentsState extends ConsumerState<_MyAppointments> {
//   @override
//   void initState() {
//     super.initState();
//     _fetchAppointments();
//   }

//   Future<void> _fetchAppointments() async {
//     final authService = ref.read(authServiceProvider.notifier);
//     await authService.fetchAppointments();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authState = ref.watch(authServiceProvider);

//     return Scaffold(
//       appBar: MyAppBar(),
//       bottomNavigationBar: MyBottomNavigationBar(),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20.0),
//           child: Column(
//             children: [
//               Text(
//                 'My Appointments',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               authState.error != null
//                   ? Text(
//                       'Error: ${authState.error}',
//                       style: TextStyle(color: Colors.red),
//                     )
//                   : authState.appointments == null
//                       ? CircularProgressIndicator()
//                       : Expanded(
//                           child: ListView.builder(
//                             itemCount: authState.appointments!.length,
//                             itemBuilder: (context, index) {
//                               final appointment =
//                                   authState.appointments![index];
//                               return ListTile(
//                                 title: Text(appointment['hairStyle']),
//                                 subtitle: Text(
//                                     '${appointment['date']} at ${appointment['time']}'),
//                                 trailing: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       icon: Icon(Icons.edit),
//                                       onPressed: () {
//                                         _editAppointmentDialog(
//                                             context, appointment);
//                                       },
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.delete),
//                                       onPressed: () {
//                                         _deleteAppointment(
//                                             appointment['id']);
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _deleteAppointment(String id) async {
//     final authService = ref.read(authServiceProvider.notifier);
//     await authService.deleteAppointment(id);
//     _fetchAppointments();
//   }

//   Future<void> _editAppointment(
//       String id,
//       String fullName,
//       String email,
//       String hairStyle,
//       String date,
//       String time,
//       String comment) async {
//     final authService = ref.read(authServiceProvider.notifier);
//     await authService.editAppointment(
//         id, fullName, email, hairStyle, date, time, comment);
//     _fetchAppointments();
//   }

//   void _editAppointmentDialog(BuildContext context, Map appointment) {
//     final fullNameController =
//         TextEditingController(text: appointment['fullName']);
//     final emailController = TextEditingController(text: appointment['email']);
//     final hairStyleController =
//         TextEditingController(text: appointment['hairStyle']);
//     final dateController = TextEditingController(text: appointment['date']);
//     final timeController = TextEditingController(text: appointment['time']);
//     final commentController =
//         TextEditingController(text: appointment['comment']);

//     String selectedStyle = appointment['hairStyle'];
//     String selectedTime = appointment['time'];
//     DateTime selectedDate = DateTime.parse(appointment['date']);

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Edit Appointment'),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//              _buildTextField(fullNameController, 'Full Name'),
//               _buildTextField(emailController, 'Email'),
//               DropdownButtonFormField<String>(
//                 value: selectedStyle,
//                 items: ['Shuruba', 'Kutirtir', 'Publis'] // Replace with actual styles
//                     .map((style) => DropdownMenuItem(
//                           value: style,
//                           child: Text(style),
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   if (value != null) {
//                     selectedStyle = value;
//                   }
//                 },
//                 decoration: InputDecoration(labelText: 'Hair Style'),
//               ),
//               TextFormField(
//                 controller: dateController,
//                 readOnly: true,
//                 decoration: InputDecoration(labelText: 'Date'),
//                 onTap: () async {
//                   DateTime? picked = await showDatePicker(
//                     context: context,
//                     initialDate: selectedDate,
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2100),
//                   );
//                   if (picked != null) {
//                     setState(() {
//                       selectedDate = picked;
//                       dateController.text = picked.toIso8601String().split('T')[0];
//                     });
//                   }
//                 },
//               ),
//               DropdownButtonFormField<String>(
//                 value: selectedTime,
//                 items: ['1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '9PM', '10PM', '11PM'] 
//                     .map((time) => DropdownMenuItem(
//                           value: time,
//                           child: Text(time),
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   if (value != null) {
//                     selectedTime = value;
//                   }
//                 },
//                 decoration: InputDecoration(labelText: 'Time'),
//               ),
//               _buildTextField(commentController, 'Comment', maxLines: 3),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await _editAppointment(
//                 appointment['id'],
//                 fullNameController.text,
//                 emailController.text,
//                 selectedStyle,
//                 dateController.text,
//                 selectedTime,
//                 commentController.text,
//               );
//               Navigator.of(context).pop();
//             },
//             child: Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String labelText,
//       {int maxLines = 1}) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(labelText: labelText),
//       maxLines: maxLines,
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/presentation/screens/home.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';
import 'package:zemnanit/presentation/screens/salonss.dart';
import 'auth_service.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
import 'package:zemnanit/presentation/screens/common_widgets/bottomnav.dart';

class MyAppointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Appointments',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyAppointments(),
      routes: {
        '/home': (context) => Home(),
        '/salons': (context) => ZemnanitApp(),
        '/appointments': (context) => MyAppointments(),
        '/logout': (context) => Login(),
      },
    );
  }
}

class _MyAppointments extends ConsumerStatefulWidget {
  @override
  ConsumerState<_MyAppointments> createState() => __MyAppointmentsState();
}

class __MyAppointmentsState extends ConsumerState<_MyAppointments> {
  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    final authService = ref.read(authServiceProvider.notifier);
    await authService.fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authServiceProvider);

    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Text(
                'My Appointments',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              authState.error != null
                  ? Text(
                      'Error: ${authState.error}',
                      style: TextStyle(color: Colors.red),
                    )
                  : authState.appointments == null
                      ? CircularProgressIndicator()
                      : Expanded(
                          child: ListView.builder(
                            itemCount: authState.appointments!.length,
                            itemBuilder: (context, index) {
                              final appointment =
                                  authState.appointments![index];
                              return ListTile(
                                title: Text(appointment['hairStyle'] ?? 'Unknown Style'),
                                subtitle: Text(
                                    '${appointment['date'] ?? 'Unknown Date'} at ${appointment['time'] ?? 'Unknown Time'}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        _editAppointmentDialog(
                                            context, appointment);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteAppointment(appointment['id']);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteAppointment(String id) async {
    final authService = ref.read(authServiceProvider.notifier);
    await authService.deleteAppointment(id);
    _fetchAppointments();
  }

  Future<void> _editAppointment(
      String id,
      String fullName,
      String email,
      String hairStyle,
      String date,
      String time,
      String comment) async {
    final authService = ref.read(authServiceProvider.notifier);
    await authService.editAppointment(
        id, fullName, email, hairStyle, date, time, comment);
    _fetchAppointments();
  }

  void _editAppointmentDialog(BuildContext context, Map appointment) {
    final fullNameController =
        TextEditingController(text: appointment['fullName'] ?? '');
    final emailController = TextEditingController(text: appointment['email'] ?? '');
    final hairStyleController =
        TextEditingController(text: appointment['hairStyle'] ?? '');
    final dateController = TextEditingController(text: appointment['date'] ?? '');
    final timeController = TextEditingController(text: appointment['time'] ?? '');
    final commentController =
        TextEditingController(text: appointment['comment'] ?? '');

    String selectedStyle = appointment['hairStyle'] ?? 'Shuruba';
    String selectedTime = appointment['time'] ?? '1PM';
    DateTime selectedDate = DateTime.tryParse(appointment['date']) ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Appointment'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(fullNameController, 'Full Name'),
              _buildTextField(emailController, 'Email'),
              DropdownButtonFormField<String>(
                value: selectedStyle,
                items: ['Shuruba', 'Kutirtir', 'Publis'] // Replace with actual styles
                    .map((style) => DropdownMenuItem(
                          value: style,
                          child: Text(style),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedStyle = value;
                  }
                },
                decoration: InputDecoration(labelText: 'Hair Style'),
              ),
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Date'),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      dateController.text = picked.toIso8601String().split('T')[0];
                    });
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedTime,
                items: ['1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '9PM', '10PM', '11PM'] 
                    .map((time) => DropdownMenuItem(
                          value: time,
                          child: Text(time),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedTime = value;
                  }
                },
                decoration: InputDecoration(labelText: 'Time'),
              ),
              _buildTextField(commentController, 'Comment', maxLines: 3),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _editAppointment(
                appointment['id'],
                fullNameController.text,
                emailController.text,
                selectedStyle,
                dateController.text,
                selectedTime,
                commentController.text,
              );
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label),
    );
  }
}
