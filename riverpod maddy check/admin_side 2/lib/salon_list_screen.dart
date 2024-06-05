import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'salon_list_provider.dart';

class SalonListScreen extends ConsumerWidget {
  final String accessToken;

  SalonListScreen({required this.accessToken});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(salonsProvider);
    final notifier = ref.read(salonsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Salons List'),
        backgroundColor: Colors.white,
      ),
      body: state.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: state.salons.length,
              itemBuilder: (context, index) {
                var salon = state.salons[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(salon['picturePath'] ?? ''),
                            radius: 30,
                          ),
                          title: TextFormField(
                            initialValue: salon['name'] ?? '',
                            onChanged: (value) {
                              salon['name'] = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          subtitle: Column(
                            children: [
                              TextFormField(
                                initialValue: salon['location'] ?? '',
                                onChanged: (value) {
                                  salon['location'] = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Location',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: salon['picturePath'] ?? '',
                                onChanged: (value) {
                                  salon['picturePath'] = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Picture URL',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(Icons.save),
                              label: Text('Save'),
                              onPressed: () {
                                notifier.editSalon(
                                  accessToken,
                                  salon['_id'] ?? '',
                                  salon['name'] ?? '',
                                  salon['location'] ?? '',
                                  salon['picturePath'] ?? '',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              onPressed: () {
                                notifier.deleteSalon(
                                    accessToken, salon['_id'] ?? '');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
