// models/salon_form_state.dart

import 'package:file_picker/file_picker.dart';

class SalonFormState {
  final String name;
  final String location;
  final FilePickerResult? pictureResult;
  final String uploadedImagePath;
  final bool isLoading;

  SalonFormState({
    required this.name,
    required this.location,
    required this.pictureResult,
    required this.uploadedImagePath,
    required this.isLoading,
  });

  SalonFormState copyWith({
    String? name,
    String? location,
    FilePickerResult? pictureResult,
    String? uploadedImagePath,
    bool? isLoading,
  }) {
    return SalonFormState(
      name: name ?? this.name,
      location: location ?? this.location,
      pictureResult: pictureResult ?? this.pictureResult,
      uploadedImagePath: uploadedImagePath ?? this.uploadedImagePath,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
