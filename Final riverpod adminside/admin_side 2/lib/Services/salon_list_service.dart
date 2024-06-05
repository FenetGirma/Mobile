// services/salon_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class SalonService {
  final http.Client httpClient;

  // Constructor accepting an optional http.Client, defaulting to a new instance if not provided
  SalonService({http.Client? client}) : httpClient = client ?? http.Client();

  // Fetching list of salons
  Future<List> fetchSalons(String accessToken) async {
    final url = 'http://localhost:3000/salons'; // Replace with your backend URL
    final response = await httpClient.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load salons: ${response.reasonPhrase}');
    }
  }

  // Editing a salon
  Future<void> editSalon(String accessToken, String salonId, String newName,
      String newLocation, String newPicturePath) async {
    final url =
        'http://localhost:3000/salons/$salonId'; // Adjust URL to your API endpoint
    final response = await httpClient.patch(
      Uri.parse(url),
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

    if (response.statusCode != 200) {
      throw Exception('Failed to update salon: ${response.reasonPhrase}');
    }
  }

  // Deleting a salon
  Future<void> deleteSalon(String accessToken, String salonId) async {
    final url =
        'http://localhost:3000/salons/$salonId'; // Adjust URL to your API endpoint
    final response = await httpClient.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete salon: ${response.reasonPhrase}');
    }
  }
}
