import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';
import 'package:admin_side/salon_list_screen.dart'; // replace with your actual import

// Generate the mock classes
@GenerateMocks([http.Client])
import 'salon_list_unit_test.mocks.dart';

void main() {
  group('SalonListScreen', () {
    late MockClient client;

    setUp(() {
      client = MockClient();
    });

    test('fetches salons successfully', () async {
      final response = [
        {
          '_id': '1',
          'name': 'Salon 1',
          'location': 'Location 1',
          'picturePath': 'http://example.com/pic1.jpg'
        }
      ];
      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(json.encode(response), 200));

      final salons = await fetchSalons(client,
          'fake_token'); // Make sure to extract the fetching logic into a function

      expect(salons, isA<List>());
      expect(salons.length, 1);
      expect(salons[0]['name'], 'Salon 1');
    });

    test('returns an empty list when fetching salons fails', () async {
      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final salons = await fetchSalons(client, 'fake_token');

      expect(salons, isEmpty);
    });
  });
}

Future<List> fetchSalons(http.Client client, String token) async {
  final url = 'http://localhost:3000/salons';
  final response = await client.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return [];
  }
}
