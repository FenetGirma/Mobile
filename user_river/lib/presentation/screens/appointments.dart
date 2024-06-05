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
        '/home': (context) => Home(email: ''),
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
    try {
      await authService.fetchAppointments();
    } catch (e) {
      print("Error fetching appointments: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authServiceProvider);

    return Scaffold(
        appBar: MyAppBar(),
        // bottomNavigationBar: MyBottomNavigationBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Text(
                  'My Appointments',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                if (authState.loading)
                  CircularProgressIndicator()
                else if (authState.error != null)
                  Text(
                    'Error: ${authState.error}',
                    style: TextStyle(color: Colors.red),
                  )
                else if (authState.appointments == null)
                  CircularProgressIndicator()
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: authState.appointments!.length,
                      itemBuilder: (context, index) {
                        final appointment = authState.appointments![index];
                        return ListTile(
                          title: Text(
                              ' ${appointment['hairstyle'] ?? ''}'),
                          subtitle: Text(
                            '${appointment['date'] ?? 'Unknown Date'} at ${appointment['time'] ?? 'Unknown Time'} \n ${appointment['comment'] ?? ''}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editAppointmentDialog(context, appointment);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteAppointment(appointment['_id']);
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
        ));
  }

  Future<void> _deleteAppointment(String id) async {
    final authService = ref.read(authServiceProvider.notifier);
    await authService.deleteAppointment(id);
    _fetchAppointments();
  }

  Future<void> _editAppointment(String id, String date, String time,
      String comment, String hairstyle) async {
    final authService = ref.read(authServiceProvider.notifier);
    await authService.editAppointment(id, hairstyle, date, time, comment);
    _fetchAppointments();
  }

  void _editAppointmentDialog(BuildContext context, Map appointment) {
    final dateController =
        TextEditingController(text: appointment['date'] ?? '');
    final commentController =
        TextEditingController(text: appointment['comment'] ?? '');
    final hairstyleController =
        TextEditingController(text: appointment['hairstyle'] ?? '');

    String selectedTime = appointment['time'] ?? '1PM';
    DateTime selectedDate =
        DateTime.tryParse(appointment['date'] ?? '') ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Appointment'),
        content: SingleChildScrollView(
          child: Column(
            children: [
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
                      dateController.text =
                          picked.toIso8601String().split('T')[0];
                    });
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedTime,
                items: [
                  '1PM',
                  '2PM',
                  '3PM',
                  '4PM',
                  '5PM',
                  '6PM',
                  '7PM',
                  '9PM',
                  '10PM',
                  '11PM'
                ]
                    .map((time) => DropdownMenuItem(
                          value: time,
                          child: Text(time),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedTime = value;
                    });
                  }
                },
                decoration: InputDecoration(labelText: 'Time'),
              ),
              _buildTextField(commentController, 'comment', maxLines: 3),
              _buildTextField(hairstyleController, 'hairstyle', maxLines: 3),
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
                appointment['_id'],
                dateController.text,
                selectedTime,
                hairstyleController.text,
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

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label),
    );
  }
}
