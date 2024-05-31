import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddSalonScreen extends StatefulWidget {
  final String accessToken;

  AddSalonScreen({required this.accessToken});

  @override
  _AddSalonScreenState createState() => _AddSalonScreenState();
}

class _AddSalonScreenState extends State<AddSalonScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';
  FilePickerResult? _pictureResult;
  String _uploadedImagePath = '';
  bool _isLoading = false;

  Future<void> _pickPicture() async {
    _pictureResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (_pictureResult != null && _pictureResult!.files.isNotEmpty) {
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected.')),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_pictureResult == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image before submitting.')),
        );
        return;
      }

      final url = 'http://localhost:3000/salons';

      setState(() {
        _isLoading = true;
      });

      try {
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers['Authorization'] = 'Bearer ${widget.accessToken}';
        request.fields['name'] = _name;
        request.fields['location'] = _location;

        // Add image file bytes
        if (_pictureResult != null &&
            _pictureResult!.files.first.bytes != null) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'file',
              _pictureResult!.files.first.bytes!,
              filename: _pictureResult!.files.first.name,
            ),
          );
        }

        var response = await request.send();
        var responseData = await http.Response.fromStream(response);

        if (response.statusCode == 201) {
          var responseBody = json.decode(responseData.body);
          setState(() {
            _uploadedImagePath = responseBody['picturePath'];
          });

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
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Salon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
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
                          _name = value!;
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
                          _location = value!;
                        },
                      ),
                      SizedBox(height: 20),
                      _pictureResult != null
                          ? Text(
                              'Picture selected: ${_pictureResult!.files.first.name}')
                          : Text('No image selected'),
                      ElevatedButton(
                        onPressed: _pickPicture,
                        child: Text('Pick Image'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
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
