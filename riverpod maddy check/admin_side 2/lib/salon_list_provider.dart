import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final salonsProvider = StateNotifierProvider<SalonsNotifier, SalonsState>(
  (ref) => SalonsNotifier(ref),
);

class SalonsState {
  final bool isLoading;
  final List<dynamic> salons;

  SalonsState({this.isLoading = false, this.salons = const []});

  SalonsState copyWith({bool? isLoading, List<dynamic>? salons}) {
    return SalonsState(
      isLoading: isLoading ?? this.isLoading,
      salons: salons ?? this.salons,
    );
  }
}

class SalonsNotifier extends StateNotifier<SalonsState> {
  SalonsNotifier(this.ref) : super(SalonsState());

  final Ref ref;
  static const String url = 'http://localhost:3000/salons';

  Future<void> fetchSalons(String accessToken) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        state = state.copyWith(
          salons: json.decode(response.body),
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
        throw Exception('Failed to load salons');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception('Error: $e');
    }
  }

  Future<void> editSalon(String accessToken, String salonId, String newName,
      String newLocation, String newPicturePath) async {
    try {
      final response = await http.patch(
        Uri.parse('$url/$salonId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': newName,
          'location': newLocation,
          'picturePath': newPicturePath,
        }),
      );

      if (response.statusCode == 200) {
        await fetchSalons(accessToken);
      } else {
        throw Exception('Failed to update salon');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteSalon(String accessToken, String salonId) async {
    try {
      final response = await http.delete(
        Uri.parse('$url/$salonId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await fetchSalons(accessToken);
      } else {
        throw Exception('Failed to delete salon');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
