import 'package:flutter/material.dart';
import 'booking.dart';

class BookingPage extends StatefulWidget {
  final Booking booking;

  const BookingPage({required this.booking});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String email = ''; // New variable to store email input
  String phone = ''; // New variable to store phone input
  bool isBookingFull = false;

  @override
  void initState() {
    super.initState();
    checkBookingFull();
  }

  void checkBookingFull() {
    if (widget.booking.bookingRemaining <= 0) {
      setState(() {
        isBookingFull = true;
      });
    } else {
      setState(() {
        isBookingFull = false;
      });
    }
  }

  // Function to handle booking a property
  void bookProperty() {
    if (!isBookingFull) {
      // Update email and phone in the booking object
      // widget.booking.email = email;
      // widget.booking.phone = phone;

      // Perform any further actions, such as saving the booking to the database or displaying a success message
    } else {
      // Display an error message or handle the case when the booking limit is reached
      print('Booking limit reached');
    }
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: bookProperty,
                    child: Text('Book Property'),
                  ),
                ),
              ],
            ),
            if (isBookingFull)
              Text(
                'Booking Full. No more bookings allowed.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
