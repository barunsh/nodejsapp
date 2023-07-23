import 'package:flutter/material.dart';
// import 'showproperty.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'property.dart';
import 'config.dart';

class BookingDetails extends StatefulWidget {
  final Property property;

  const BookingDetails({required this.property});

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Details'),
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
          ],
        ),
      ),
    );
  }
}
