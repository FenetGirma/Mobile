// ui/add_salon_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/salon_form_provider.dart';
import '../../services/salon_service.dart';

class AddSalonScreen extends ConsumerWidget {
  final String accessToken;

  AddSalonScreen({required this.accessToken});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(salonFormProvider);
    final formNotifier = ref.read(salonFormProvider.notifier);
    final salonService = SalonService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Salon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: formState.isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Salon Name'),
                        onChanged: (value) => formNotifier.updateName(value),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Location'),
                        onChanged: (value) =>
                            formNotifier.updateLocation(value),
                      ),
                      SizedBox(height: 20),
                      formState.pictureResult != null
                          ? Text(
                              'Picture selected: ${formState.pictureResult!.files.first.name}')
                          : Text('No image selected'),
                      ElevatedButton(
                        onPressed: formNotifier.pickPicture,
                        child: Text('Pick Image'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => salonService.submitForm(
                          context,
                          accessToken,
                          formState.name,
                          formState.location,
                          formState.pictureResult,
                        ),
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
