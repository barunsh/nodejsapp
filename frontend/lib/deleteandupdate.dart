import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateDeletePage extends StatelessWidget {
  TextEditingController namesController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void updateRecord(BuildContext context) async {
    final Map<String, dynamic> updateData = {
      'names': namesController.text,
      'email': emailController.text,
      'phone': int.parse(phoneController.text),
    };

    final response = await http.put(
      Uri.parse('http://localhost:3000/updateUser/'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updateData),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Record updated successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update record.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void deleteRecord(BuildContext context) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/deleteUser/'),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Record deleted successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to delete record.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update and Delete'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text('2. Names'),
            TextField(controller: namesController),
            SizedBox(height: 16),
            Text('3. Email'),
            TextField(controller: emailController),
            SizedBox(height: 16),
            Text('4. Phone'),
            TextField(controller: phoneController),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => updateRecord(context),
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () => deleteRecord(context),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update and Delete',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UpdateDeletePage(),
    );
  }
}
