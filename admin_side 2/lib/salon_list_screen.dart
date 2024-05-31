import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SalonListScreen extends StatefulWidget {
  final String accessToken;

  SalonListScreen({required this.accessToken});

  @override
  _SalonListScreenState createState() => _SalonListScreenState();
}

class _SalonListScreenState extends State<SalonListScreen> {
  bool _isLoading = false;
  List _salons = [];

  @override
  void initState() {
    super.initState();
    _fetchSalons();
  }

  Future<void> _fetchSalons() async {
    setState(() {
      _isLoading = true;
    });

    final url = 'http://localhost:3000/salons'; // Replace with your backend URL
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _salons = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load salons')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _editSalon(
      String salonId, String newName, String newLocation) async {
    final url =
        'http://localhost:3000/salons/$salonId'; // Adjust URL to your API endpoint

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': newName,
          'location': newLocation,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Salon updated successfully')),
        );
        // Refresh salon list or update UI as needed
        _fetchSalons();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update salon')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salons List'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _salons.length,
              itemBuilder: (context, index) {
                var salon = _salons[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      salon[
                          'picturePath'], // Assuming 'picturePath' is the URL to the salon picture
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: TextFormField(
                      initialValue: salon['name'], // Display the current name
                      onChanged: (value) {
                        salon['name'] = value; // Update the name when edited
                      },
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    subtitle: TextFormField(
                      initialValue:
                          salon['location'], // Display the current location
                      onChanged: (value) {
                        salon['location'] =
                            value; // Update the location when edited
                      },
                      decoration: InputDecoration(labelText: 'Location'),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.save),
                          onPressed: () {
                            _editSalon(
                              salon['id'], // Pass the salon ID
                              salon['name'], // Pass the updated name
                              salon['location'], // Pass the updated location
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Implement delete functionality
                          },
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
