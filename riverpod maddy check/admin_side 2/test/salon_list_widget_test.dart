import 'package:admin_side/salon_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';

@GenerateMocks([http.Client])
import 'salon_list_widget_test.mocks.dart';

void main() {
  group('SalonListScreen Widget Tests', () {
    late MockClient client; // Use the generated MockClient

    setUp(() {
      client = MockClient(); // Instantiate the mock client
    });

    // testWidgets('displays list of salons', (WidgetTester tester) async {
    //   // Mock response data
    //   final response = [
    //     {
    //       '_id': '1',
    //       'name': 'Salon 1',
    //       'location': 'Location 1',
    //       'picturePath': 'http://example.com/pic1.jpg'
    //     }
    //   ];

    //   // Mock the HTTP client response
    //   when(client.get(any, headers: anyNamed('headers')))
    //       .thenAnswer((_) async => http.Response(json.encode(response), 200));

    //   // Build the widget with the mocked client
    //   await tester.pumpWidget(MaterialApp(
    //     home: SalonListScreen(accessToken: 'fake_token', client: client),
    //   ));

    //   // Wait for the widget to fully render
    //   await tester.pump();

    //   // Verify that the salon name and location are displayed
    //   expect(find.text('Salon 1'), findsOneWidget);
    //   expect(find.text('Location 1'), findsOneWidget);
    // });

    testWidgets('displays loading indicator while fetching salons',
        (WidgetTester tester) async {
      // Mock the HTTP client response with a delayed future
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Future.delayed(
              Duration(seconds: 2), () => http.Response('[]', 200)));

      // Build the widget with the mocked client
      await tester.pumpWidget(MaterialApp(
        home: SalonListScreen(accessToken: 'fake_token', client: client),
      ));

      // Verify that the loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for the future to complete
      await tester.pumpAndSettle();

      // Verify that the loading indicator is no longer displayed
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
