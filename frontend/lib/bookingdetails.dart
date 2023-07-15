import 'package:flutter/material.dart';// import 'package:http/http.dart' as http;
import 'showproperty.dart';

class BookingDetails extends StatelessWidget {
  final Booking booking;

  const BookingDetails({required this.booking});

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
              'Property Name: ${booking.propertyName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text('Property Address: ${booking.propertyAddress}'),
            SizedBox(height: 8),
            Text('Property Rent: Rs. ${booking.propertyRent}'),
            SizedBox(height: 8),
            Text('Property Type: ${booking.propertyType}'),
            SizedBox(height: 8),
            Text('Property Balcony Count: ${booking.propertyBalconyCount}'),
            SizedBox(height: 8),
            Text('Property Bedroom Count: ${booking.propertyBedroomCount}'),
            SizedBox(height: 8),
            Text('Property Date: ${booking.propertyDate.toString()}'),
          ],
        ),
      ),
    );
  }
}
