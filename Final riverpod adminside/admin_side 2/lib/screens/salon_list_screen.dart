// ui/salon_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/salon_list_provider.dart';

class SalonListScreen extends ConsumerStatefulWidget {
  final String accessToken;

  SalonListScreen({required this.accessToken});

  @override
  _SalonListScreenState createState() => _SalonListScreenState();
}

class _SalonListScreenState extends ConsumerState<SalonListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(salonListProvider.notifier).fetchSalons(widget.accessToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    final salonListState = ref.watch(salonListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Salons List'),
        backgroundColor: Colors.blue,
      ),
      body: salonListState.isLoading
          ? Center(child: CircularProgressIndicator())
          : salonListState.error.isNotEmpty
              ? Center(child: Text(salonListState.error))
              : ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: salonListState.salons.length,
                  itemBuilder: (context, index) {
                    var salon = salonListState.salons[index];
                    return Card(
                      elevation: 5,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
                              title: Text(salon['name'] ?? ''),
                              subtitle: Text(salon['location'] ?? ''),
                            ),
                            TextFormField(
                              initialValue: salon['name'] ?? '',
                              onChanged: (value) {
                                salon['name'] = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 10),
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
                            ButtonBar(
                              alignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  icon: Icon(Icons.save),
                                  label: Text('Save'),
                                  onPressed: () {
                                    ref
                                        .read(salonListProvider.notifier)
                                        .editSalon(
                                          widget.accessToken,
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
                                    ref
                                        .read(salonListProvider.notifier)
                                        .deleteSalon(
                                          widget.accessToken,
                                          salon['_id'] ?? '',
                                        );
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
