// providers/salon_form_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../models/salon_form_state.dart';

final salonFormProvider =
    StateNotifierProvider<SalonFormNotifier, SalonFormState>((ref) {
  return SalonFormNotifier();
});

class SalonFormNotifier extends StateNotifier<SalonFormState> {
  SalonFormNotifier()
      : super(SalonFormState(
          name: '',
          location: '',
          pictureResult: null,
          uploadedImagePath: '',
          isLoading: false,
        ));

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateLocation(String location) {
    state = state.copyWith(location: location);
  }

  Future<void> pickPicture() async {
    final pictureResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (pictureResult != null && pictureResult.files.isNotEmpty) {
      state = state.copyWith(pictureResult: pictureResult);
    }
  }
}
