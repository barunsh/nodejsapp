import 'package:flutter/material.dart';
// import 'showproperty.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'booking.dart';

class BookingDetails extends StatefulWidget {
  final Booking booking;

  const BookingDetails({required this.booking});

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
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
              'Property Address: ${widget.booking.propertyAddress}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text('Property Address: ${widget.booking.propertyAddress}'),
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
          ],
        ),
      ),
    );
  }
}
