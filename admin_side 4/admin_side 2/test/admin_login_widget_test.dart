import 'package:admin_side/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart'
    hide MockClient; // Hide MockClient from http/testing.dart
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:admin_side/login_admin.dart'; // Adjust this import according to your project structure
import 'package:mockito/annotations.dart';

import 'admin_login_widget_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('AdminLoginPage', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    Future<void> pumpAdminLoginPage(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AdminLoginPage(httpClient: mockClient),
        ),
      );
      await tester.pump(); // Add pump to ensure widget is fully built
    }

    testWidgets('displays login form', (WidgetTester tester) async {
      await pumpAdminLoginPage(tester);

      expect(find.text('Admin Login'), findsOneWidget);
      expect(find.byType(TextField),
          findsNWidgets(2)); // Expect two text fields: email and password
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('logs in successfully', (WidgetTester tester) async {
      final response = {
        'access_token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiQWRtaW4ifQ.sflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
      };

      when(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(response), 200));

      await pumpAdminLoginPage(tester);

      await tester.enterText(find.byType(TextField).at(0), 'admin@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(); // Use pumpAndSettle to wait for navigation

      verify(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).called(1);

      // Check for navigation to AdminDashboard
      expect(find.byType(AdminDashboard), findsOneWidget);
    });

    testWidgets('displays error message on login failure',
        (WidgetTester tester) async {
      when(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Unauthorized', 401));

      await pumpAdminLoginPage(tester);

      await tester.enterText(find.byType(TextField).at(0), 'admin@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');
      await tester.tap(find.byType(ElevatedButton));
      await tester
          .pumpAndSettle(); // Use pumpAndSettle to wait for state change

      expect(find.text('Invalid email or password'), findsOneWidget);
    });
  });
}
