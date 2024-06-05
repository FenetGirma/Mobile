import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final addSalonProvider = StateNotifierProvider<AddSalonNotifier, AddSalonState>(
  (ref) => AddSalonNotifier(),
);

class AddSalonState {
  final String name;
  final String location;
  final FilePickerResult? pictureResult;
  final String uploadedImagePath;
  final bool isLoading;

  AddSalonState({
    this.name = '',
    this.location = '',
    this.pictureResult,
    this.uploadedImagePath = '',
    this.isLoading = false,
  });

  AddSalonState copyWith({
    String? name,
    String? location,
    FilePickerResult? pictureResult,
    String? uploadedImagePath,
    bool? isLoading,
  }) {
    return AddSalonState(
      name: name ?? this.name,
      location: location ?? this.location,
      pictureResult: pictureResult ?? this.pictureResult,
      uploadedImagePath: uploadedImagePath ?? this.uploadedImagePath,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AddSalonNotifier extends StateNotifier<AddSalonState> {
  AddSalonNotifier() : super(AddSalonState());

  Future<void> pickPicture() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      state = state.copyWith(pictureResult: result);
    } else {
      throw Exception('No file selected');
    }
  }

  Future<void> submitForm(String accessToken) async {
    if (state.pictureResult == null) {
      throw Exception('Please select an image before submitting.');
    }

    final url = 'http://localhost:3000/salons';

    state = state.copyWith(isLoading: true);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['name'] = state.name;
      request.fields['location'] = state.location;

      if (state.pictureResult != null &&
          state.pictureResult!.files.first.bytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            state.pictureResult!.files.first.bytes!,
            filename: state.pictureResult!.files.first.name,
          ),
        );
      }

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 201) {
        var responseBody = json.decode(responseData.body);
        state = state.copyWith(
          uploadedImagePath: responseBody['picturePath'],
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
        var errorResponse = json.decode(responseData.body);
        throw Exception('Failed to add salon: ${errorResponse['message']}');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception('Error: $e');
    }
  }
}
