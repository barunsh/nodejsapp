import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'booking.dart';
import 'showproperty.dart';

class BookingPage extends StatefulWidget {
  final Booking booking;
  final String? names;
  final String? email;
  final int? phone;
  final String? id;

  BookingPage({required this.booking, this.id, this.names, this.email, this.phone});

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
              'Property Name: ${widget.booking.propertyName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text('Property Address: ${widget.booking.propertyAddress}'),
            SizedBox(height: 8),
            Text('Property Rent: Rs. ${widget.booking.propertyRent}'),
            SizedBox(height: 8),
            Text('Property Type: ${widget.booking.propertyType}'),
            SizedBox(height: 8),
            Text('Property Balcony Count: ${widget.booking.propertyBalconyCount}'),
            SizedBox(height: 8),
            Text('Property Bedroom Count: ${widget.booking.propertyBedroomCount}'),
            SizedBox(height: 8),
            Text('Property Date: ${widget.booking.propertyDate.toString()}'),
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
      'propertyName': widget.booking.propertyName,
      'propertyAddress': widget.booking.propertyAddress,
      'propertyRent': widget.booking.propertyRent,
      'propertyType': widget.booking.propertyType,
      'propertyBalconyCount': widget.booking.propertyBalconyCount,
      'propertyBedroomCount': widget.booking.propertyBedroomCount,
      'propertyDate': widget.booking.propertyDate.toString(),
    };

    final response = await http.post(
      Uri.parse('http://localhost:3000/bookings'),
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GetDataPage(),
          ),
        );
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
