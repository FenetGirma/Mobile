import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_salon_provider.dart';

class AddSalonScreen extends ConsumerWidget {
  final String accessToken;

  AddSalonScreen({required this.accessToken});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addSalonProvider);
    final notifier = ref.read(addSalonProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Salon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: state.isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: GlobalKey<FormState>(),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Salon Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a salon name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          notifier.state =
                              notifier.state.copyWith(name: value!);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Location'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          notifier.state =
                              notifier.state.copyWith(location: value!);
                        },
                      ),
                      SizedBox(height: 20),
                      state.pictureResult != null
                          ? Text(
                              'Picture selected: ${state.pictureResult!.files.first.name}')
                          : Text('No image selected'),
                      ElevatedButton(
                        onPressed: () => notifier.pickPicture(),
                        child: Text('Pick Image'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => notifier.submitForm(accessToken),
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
