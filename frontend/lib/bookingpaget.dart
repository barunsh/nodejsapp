import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'booking.dart';

class BookingPage extends StatefulWidget {
  final Booking booking;
  final String? names;
  final String? email;
  final int? phone;

  BookingPage({required this.booking, this.names, this.email, this.phone});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController namesController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    bringDetails();
  }

  void bringDetails() {
    if (widget.names != null && widget.phone != null && widget.email != null) {
      setState(() {
        namesController.text = widget.names!;
        emailController.text = widget.email!;
        phoneController.text = widget.phone.toString();
      });
    } else {
      setState(() {
        namesController.text = ''; // Set the names field to an empty string
        emailController.text = ''; // Set the email field to an empty string
        phoneController.text = ''; // Set the phone field to an empty string
      });
    }
  }

  void bookProperty() async {
  // Update email and phone in the booking object
  String email = emailController.text;
  int phone = int.parse(phoneController.text);

  final Map<String, dynamic> requestBody = {
    'propertyName': widget.booking.propertyName,
    'propertyAddress': widget.booking.propertyAddress,
    'propertyRent': widget.booking.propertyRent,
    'propertyType': widget.booking.propertyType,
    'propertyBalconyCount': widget.booking.propertyBalconyCount,
    'propertyBedroomCount': widget.booking.propertyBedroomCount,
    'propertyDate': widget.booking.propertyDate.toString(),
    'names': namesController.text.isEmpty ? 'N/A' : namesController.text,
    'email': email,
    'phone': phone,
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
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to book property'),
        ),
      );
    }
  } else {
    print('Server responded with status code ${response.statusCode}');
  }
}


  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    namesController.dispose();
    super.dispose();
  }

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
            Text(
              'Names: ${namesController.text.isEmpty ? 'N/A' : namesController.text}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: bringDetails,
                  child: Text('Bring Details'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: bookProperty,
                    child: Text('Book Property'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}