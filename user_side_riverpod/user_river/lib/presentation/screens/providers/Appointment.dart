import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final appointmentNotifierProvider =
    StateNotifierProvider<AppointmentNotifier, AppointmentState>(
  (ref) => AppointmentNotifier(ref),
);

class AppointmentNotifier extends StateNotifier<AppointmentState> {
  final StateNotifierProviderRef<AppointmentNotifier, AppointmentState> ref;
  AppointmentNotifier(this.ref) : super(AppointmentState());

  Future<void> editAppointment(String id, String picturePath, String date,
      String time, String comment) async {
    final url =
        'http://localhost:3000/appointments/$id'; // Adjust URL to your API endpoint

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'picturePath': picturePath,
          'date': date,
          'time': time,
          'comment': comment,
        }),
      );

      if (response.statusCode == 200) {
        state = state.copyWith(message: "Appointment updated successfully");
        ScaffoldMessenger.of(ref.read(navigationKeyProvider).currentContext!)
            .showSnackBar(
          SnackBar(content: Text('Appointment updated successfully')),
        );
      } else if (response.statusCode == 400) {
        state = state.copyWith(error: "Bad Request: Invalid data provided");
        ScaffoldMessenger.of(ref.read(navigationKeyProvider).currentContext!)
            .showSnackBar(
          SnackBar(content: Text('Bad Request: Invalid data provided')),
        );
      } else if (response.statusCode == 401) {
        state = state.copyWith(error: "Unauthorized: Invalid access token");
        ScaffoldMessenger.of(ref.read(navigationKeyProvider).currentContext!)
            .showSnackBar(
          SnackBar(content: Text('Unauthorized: Invalid access token')),
        );
      } else if (response.statusCode == 404) {
        state = state.copyWith(error: "Not Found: Appointment does not exist");
        ScaffoldMessenger.of(ref.read(navigationKeyProvider).currentContext!)
            .showSnackBar(
          SnackBar(content: Text('Not Found: Appointment does not exist')),
        );
      } else if (response.statusCode == 500) {
        state = state.copyWith(
            error: "Internal Server Error: Please try again later");
        ScaffoldMessenger.of(ref.read(navigationKeyProvider).currentContext!)
            .showSnackBar(
          SnackBar(
              content: Text('Internal Server Error: Please try again later')),
        );
      } else {
        state = state.copyWith(
            error: "Failed to update appointment: ${response.reasonPhrase}");
        ScaffoldMessenger.of(ref.read(navigationKeyProvider).currentContext!)
            .showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to update appointment: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
      ScaffoldMessenger.of(ref.read(navigationKeyProvider).currentContext!)
          .showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}

class AppointmentState {
  final String? message;
  final String? error;

  AppointmentState({this.message, this.error});

  AppointmentState copyWith({String? message, String? error}) {
    return AppointmentState(
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}

final navigationKeyProvider =
    Provider<GlobalKey<NavigatorState>>((_) => GlobalKey<NavigatorState>());
