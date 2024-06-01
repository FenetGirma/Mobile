import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthState {
  final String? message;
  final List<dynamic>? appointments;
  final String? error;
  final String? email;
  final String? fullname;
  final String? accessToken;
  final List<dynamic>? salons;
  final bool loading;

  AuthState({
    this.message,
    this.salons,
    this.fullname,
    this.appointments,
    this.error,
    this.email,
    this.accessToken,
    this.loading = false,
  });
}

class AuthService extends StateNotifier<AuthState> {
  AuthService() : super(AuthState());

  final String baseUrl = 'http://localhost:3000';

  Future<void> signup(
      String email, String password, String fullname, String age) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'fullname': fullname,
          'age': age,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = AuthState(message: "User created successfully");
      } else {
        throw Exception(
            'Failed to create user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    state = AuthState(loading: true); // Set loading state

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        final accessToken =
            responseBody['access_token']; // Ensure this key exists in response
        state = AuthState(
          message: "Logged in successfully",
          email: email,
          accessToken: accessToken,
        );
      } else if (response.statusCode == 401) {
        throw Exception('Invalid email or password');
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final errorMessage = responseBody['error'] ?? 'Failed to login';
        throw Exception(
            'Failed to login. Status code: ${response.statusCode}. Error: $errorMessage');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    } finally {
      state = AuthState(loading: false); // Reset loading state
    }
  }

  Future<void> bookSalon(
      String hairstyle, String date, String time, String comment) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/appointments'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'hairstyle': hairstyle,
          'date': date,
          'time': time,
          'comment': comment,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = AuthState(message: "Booking successful");
      } else {
        throw Exception(
            'Failed to book salon. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> fetchAppointments() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/appointments'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final appointments = json.decode(response.body);
        state = AuthState(appointments: appointments);
      } else {
        throw Exception(
            'Failed to fetch appointments. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> fetchSalons() async {
    state = AuthState(loading: true); // Set loading state

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/salons'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final salons = json.decode(response.body);
        state = AuthState(salons: salons, loading: false);
      } else {
        throw Exception(
            'Failed to fetch salons. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString(), loading: false);
    }
  }

  Future<void> editAppointment(String id, String hairstyle, String date,
      String time, String comment) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/appointments/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'hairstyle': hairstyle,
          'date': date,
          'time': time,
          'comment': comment,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        state = AuthState(message: "Appointment updated successfully");
      } else {
        throw Exception(
            'Failed to update appointment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> deleteAppointment(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/appointments/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        state = AuthState(message: "Appointment deleted successfully");
      } else {
        throw Exception(
            'Failed to delete appointment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> updatePassword(String email, String password) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        state = AuthState(message: "Password updated successfully");
      } else {
        throw Exception(
            'Failed to update password. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> deleteUser(String email) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/users/$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        state = AuthState(message: "User deleted successfully");
      } else {
        throw Exception(
            'Failed to delete user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  void logout() {
    state = AuthState();
  }
}

// Create a provider for the AuthService
final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  return AuthService();
});
