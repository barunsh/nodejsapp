import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'property.dart';
import 'showproperty.dart';
import 'config.dart';

class BookingPage extends StatefulWidget {
  final Property property;
  final String? names;
  final String? email;
  final String? phone;
  final String? id;

  BookingPage({required this.property, this.id, this.names, this.email, this.phone});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property Address: ${widget.property.propertyAddress}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text('Property Address: ${widget.property.propertyAddress}'),
            SizedBox(height: 8),
            Text('Property Rent: Rs. ${widget.property.propertyRent}'),
            SizedBox(height: 8),
            Text('Property Type: ${widget.property.propertyType}'),
            SizedBox(height: 8),
            Text('Property Balcony Count: ${widget.property.propertyBalconyCount}'),
            SizedBox(height: 8),
            Text('Property Bedroom Count: ${widget.property.propertyBedroomCount}'),
            SizedBox(height: 8),
            Text('Property Date: ${widget.property.propertyDate.toString()}'),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Names: ${widget.names ?? 'N/A'}',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  'Email: ${widget.email ?? 'N/A'}',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  'id: ${widget.id ?? 'N/A'}',
                  style: TextStyle(fontSize: 10),
                ),
                
              ],
            ),
            ElevatedButton(
              onPressed: bookProperty,
              child: Text('Book Property'),
            ),
            Text(
                  'phone: ${widget.phone ?? 'N/A'}',
                  style: TextStyle(fontSize: 10),
                ),
          ],
        ),
      ),
    );
  }

  void bookProperty() async {
    final Map<String, dynamic> requestBody = {
      'userId': widget.id,
      'userName': widget.names,
      'propertyAddress': widget.property.propertyAddress,
      'propertyLocality': widget.property.propertyLocality,
      'propertyRent': widget.property.propertyRent,
      'propertyType': widget.property.propertyType,
      'propertyBalconyCount': widget.property.propertyBalconyCount,
      'propertyBedroomCount': widget.property.propertyBedroomCount,
      'propertyDate': widget.property.propertyDate.toString(),
    };

    final response = await http.post(
  Uri.parse('$createBook'),
  headers: {"Content-Type": "application/json"},
  body: jsonEncode(requestBody),
);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking successful'),
            duration: Duration(seconds: 2),
          ),
        );
        // Redirect to ShowPropertyPage after successful booking
      Navigator.pop(context);

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to book property'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      print('Server responded with status code ${response.statusCode}');
    }
  }
}
