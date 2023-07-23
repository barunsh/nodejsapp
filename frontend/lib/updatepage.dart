import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateUserScreen extends StatefulWidget {
  final int id;
  final String names;
  final String phone;
  final String email;
  final String role;

  UpdateUserScreen({
    required this.id,
    required this.names,
    required this.phone,
    required this.email,
    required this.role,
  });

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  TextEditingController _namesController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namesController.text = widget.names;
    _phoneController.text = widget.phone;
    _emailController.text = widget.email;
    _roleController.text = widget.role;
  }

  @override
  void dispose() {
    _namesController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    // Handle form submission for updating the user
    // You can get updated values from _namesController.text,
    // _phoneController.text, _emailController.text,
    // _roleController.text and update the user accordingly

    final updatedNames = _namesController.text;
    final updatedPhone = int.tryParse(_phoneController.text) ?? 0;
    final updatedEmail = _emailController.text;
    final updatedRole = _roleController.text;
     print('Updating user with ID: ${widget.id}');

    // Perform the update API call here
    // final updateUser = 'http://localhost:3000/updateuser/${widget.id.toString()}';
    final updateUser = 'http://localhost:3000/updateuser/${widget.id}';
     // Dynamic ID in the API endpoint
    try {
      final response = await http.put(
  Uri.parse(updateUser),
  headers: {'Content-Type': 'application/json'}, // Set the Content-Type header
  body: jsonEncode({
    'names': updatedNames,
    'phone' : updatedPhone,
    'email': updatedEmail,
    'role': updatedRole,
  }),
);

      if (response.statusCode == 200) {
        // User updated successfully
        // Handle the success scenario here
        print('User updated successfully');
      } else {
        // Failed to update user
        // Handle the failure scenario here
        print('Failed to update user: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Error occurred while updating user
      // Handle the error scenario here
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${widget.id}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _namesController,
                decoration: InputDecoration(labelText: 'Names'),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _roleController,
                decoration: InputDecoration(labelText: 'Role'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: submitForm,
                    child: Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle form submission for deleting the user
                      // You can delete the user with the given ID
                    },
                    child: Text('Delete User'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
