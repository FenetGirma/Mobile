// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zemnanit/presentation/screens/appointments.dart';
// import 'package:zemnanit/presentation/screens/common_widgets/bottomnav.dart';
// import 'package:zemnanit/presentation/screens/home.dart';
// import 'package:zemnanit/presentation/screens/login_user.dart';
// import 'package:zemnanit/presentation/screens/salonss.dart';
// import 'auth_service.dart';


// void main() {
//   runApp(ZemnanitAppp());
// }

// class ZemnanitAppp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Salon List App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       routes: {
//         '/home': (context) => Home(),
//         '/salons': (context) => ZemnanitApp(),
//         '/appointments': (context) => MyAppointments(),
//         '/logout': (context) => Login(),
//         '/book': (context) => ZemnanitDrop(), 
//       },
//       home: ZemnanitDrop(),
//     );
//   }
// }
// class ZemnanitDrop extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<ZemnanitDrop> createState() => _BookingPageState();
// }

// class _BookingPageState extends ConsumerState<ZemnanitDrop> {
//   final TextEditingController fullnameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController commentController = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   String selectedStyle = 'Shuruba';
//   String selectedTime = '1PM';
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book a Salon'),
//         backgroundColor: Color(0xE6FFFFFF),
//       ),
//       backgroundColor: Color(0xFFF1CFC3),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildTextField(fullnameController, 'Full Name', 'Enter your full name'),
//               SizedBox(height: 10),
//               _buildTextField(emailController, 'Email', 'Enter your email'),
//               SizedBox(height: 10),
//               _buildDropdown('Choose a hair style', selectedStyle, ['Shuruba', 'Kutirtir', 'Publis'], (newStyle) {
//                 setState(() {
//                   selectedStyle = newStyle!;
//                 });
//               }),
//               SizedBox(height: 10),
//               _buildDropdown('Select Time', selectedTime, ['1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '9PM', '10PM', '11PM'], (newTime) {
//                 setState(() {
//                   selectedTime = newTime!;
//                 });
//               }),
//               SizedBox(height: 10),
//               _buildDatePicker(context),
//               SizedBox(height: 10),
//               _buildTextField(commentController, 'Comments', 'Provide any specific instruction or additional comment'),
//               SizedBox(height: 20),
//               _buildSubmitButton(context),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: MyBottomNavigationBar(),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String labelText, String hintText) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: labelText,
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//       ),
//     );
//   }

//   Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 16),
//         ),
//         DropdownButton<String>(
//           value: value,
//           onChanged: onChanged,
//           items: items.map((value) => DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           )).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildDatePicker(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           'Select a date:',
//           style: TextStyle(fontSize: 16),
//         ),
//         Spacer(),
//         ElevatedButton(
//           onPressed: () async {
//             DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: selectedDate,
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2101),
//             );
//             if (picked != null && picked != selectedDate) {
//               setState(() {
//                 selectedDate = picked;
//               });
//             }
//           },
//           child: Text(
//             '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//             style: TextStyle(fontSize: 16),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSubmitButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         final fullName = fullnameController.text;
//         final email = emailController.text;
//         final hairStyle = selectedStyle;
//         final date = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
//         final time = selectedTime;
//         final comment = commentController.text;

//         ref.read(authServiceProvider.notifier).bookSalon(
//           fullName,
//           email,
//           hairStyle,
//           date,
//           time,
//           comment,
//         );

//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Booking Confirmed'),
//               content: Text('Your booking has been successfully submitted.'),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _clearForm();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       child: Text('Book'),
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.white, backgroundColor: Colors.black54,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//       ),
//     );
//   }

//   void _clearForm() {
//     fullnameController.clear();
//     emailController.clear();
//     commentController.clear();
//     setState(() {
//       selectedDate = DateTime.now();
//       selectedStyle = 'Shuruba';
//       selectedTime = '1PM';
//     });
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zemnanit/presentation/screens/appointments.dart';
import 'package:zemnanit/presentation/screens/common_widgets/bottomnav.dart';
import 'package:zemnanit/presentation/screens/home.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';
import 'package:zemnanit/presentation/screens/salonss.dart';
import 'auth_service.dart';

void main() {
  runApp(ZemnanitApp());
}

class ZemnanitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Salon List App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/home': (context) => Home(),
          '/salons': (context) => SalonListScreen(),
          '/appointments': (context) => MyAppointments(),
          '/logout': (context) => Login(),
          '/book': (context) => ZemnanitDrop(),
        },
        home: ZemnanitDrop(),
      ),
    );
  }
}

class ZemnanitDrop extends ConsumerStatefulWidget {
  @override
  ConsumerState<ZemnanitDrop> createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<ZemnanitDrop> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String selectedStyle = 'Shuruba';
  String selectedTime = '1PM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Salon'),
        backgroundColor: Color(0xE6FFFFFF),
      ),
      backgroundColor: Color(0xFFF1CFC3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(fullnameController, 'Full Name', 'Enter your full name'),
              SizedBox(height: 10),
              _buildTextField(emailController, 'Email', 'Enter your email'),
              SizedBox(height: 10),
              _buildDropdown('Choose a hair style', selectedStyle, ['Shuruba', 'Kutirtir', 'Publis'], (newStyle) {
                setState(() {
                  selectedStyle = newStyle!;
                });
              }),
              SizedBox(height: 10),
              _buildDropdown('Select Time', selectedTime, ['1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '9PM', '10PM', '11PM'], (newTime) {
                setState(() {
                  selectedTime = newTime!;
                });
              }),
              SizedBox(height: 10),
              _buildDatePicker(context),
              SizedBox(height: 10),
              _buildTextField(commentController, 'Comments', 'Provide any specific instruction or additional comment'),
              SizedBox(height: 20),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          items: items.map((value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Row(
      children: [
        Text(
          'Select a date:',
          style: TextStyle(fontSize: 16),
        ),
        Spacer(),
        ElevatedButton(
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
          child: Text(
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final fullName = fullnameController.text;
        final email = emailController.text;
        final hairStyle = selectedStyle;
        final date = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
        final time = selectedTime;
        final comment = commentController.text;
        

        ref.read(authServiceProvider.notifier).bookSalon(

          fullName,
          email,
          hairStyle,
          date,
          time,
          comment,
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Booking Confirmed'),
              content: Text('Your booking has been successfully submitted.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _clearForm();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Text('Book'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  void _clearForm() {
    fullnameController.clear();
    emailController.clear();
    commentController.clear();
    setState(() {
      selectedDate = DateTime.now();
      selectedStyle = 'Shuruba';
      selectedTime = '1PM';
    });
  }
}
