// services/salon_service.dart

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SalonService {
  Future<void> submitForm(
    BuildContext context,
    String accessToken,
    String name,
    String location,
    FilePickerResult? pictureResult,
  ) async {
    if (name.isEmpty || location.isEmpty || pictureResult == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image')),
      );
      return;
    }

    final url = 'http://localhost:3000/salons';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['name'] = name;
      request.fields['location'] = location;

      if (pictureResult != null && pictureResult.files.first.bytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            pictureResult.files.first.bytes!,
            filename: pictureResult.files.first.name,
          ),
        );
      }

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 201) {
        var responseBody = json.decode(responseData.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Salon added successfully!')),
        );
      } else {
        var errorResponse = json.decode(responseData.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to add salon: ${errorResponse['message']}')),
        );
      }
    } finally {
      // Reset the loading state
    }
  }
}
