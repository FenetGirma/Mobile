// test/token_decoder_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:admin_side/token_decoder.dart';

void main() {
  group('TokenDecoder', () {
    test('decodeToken should decode a valid JWT token', () {
      final token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiQWRtaW4ifQ.sflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
      final decoded = TokenDecoder.decodeToken(token);

      expect(decoded['role'], 'Admin');
    });

    test('decodeToken should throw an exception for an invalid token', () {
      final token = 'invalid.token.here';

      expect(() => TokenDecoder.decodeToken(token), throwsException);
    });
  });
}
