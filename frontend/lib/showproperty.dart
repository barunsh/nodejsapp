import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostListing extends StatelessWidget {
  const PostListing({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.home),
            SizedBox(width: 8),
            Text('Listings'),
          ],
        ),
      ),
      body: GetDataPage(),
    );
  }
}

class GetDataPage extends StatefulWidget {
  @override
  _GetDataPageState createState() => _GetDataPageState();
}

class _GetDataPageState extends State<GetDataPage> {
  List<Booking> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/getbooking'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == true && jsonData['booking'] is List) {
          setState(() {
            bookings = (jsonData['booking'] as List<dynamic>)
                .map((item) => Booking.fromJson(item))
                .toList();
          });
        } else {
          print('Invalid response format or no booking data');
        }
      } else {
        print('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return CardWidget(
                  image: AssetImage('assets/images/modern.jpg'),
                  amount: 'Rs. ${booking.propertyRent}',
                  title: booking.propertyName,
                  description: booking.propertyAddress,
                );
              },
            ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final ImageProvider<Object> image;
  final String amount;
  final String title;
  final String description;

  const CardWidget({
    required this.image,
    required this.amount,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 8, 2),
                  child: Image(
                    image: image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(description),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () {
                    // Handle first button press
                  },
                  child: Text('Call the owner'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () {
                    // Handle second button press
                  },
                  child: Text('Book Now'),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class Booking {
  final String propertyName;
  final String propertyAddress;
  final int propertyRent;
  final String propertyType;
  final int propertyBalconyCount;
  final int propertyBedroomCount;
  final DateTime propertyDate;

  Booking({
    required this.propertyName,
    required this.propertyAddress,
    required this.propertyRent,
    required this.propertyType,
    required this.propertyBalconyCount,
    required this.propertyBedroomCount,
    required this.propertyDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      propertyName: json['propertyName'] ?? '',
      propertyAddress: json['propertyAddress'] ?? '',
      propertyRent: json['propertyRent'] ?? 0,
      propertyType: json['propertyType'] ?? '',
      propertyBalconyCount: json['propertyBalconyCount'] ?? 0,
      propertyBedroomCount: json['propertyBedroomCount'] ?? 0,
      propertyDate: json['propertyDate'] != null
          ? DateTime.parse(json['propertyDate'])
          : DateTime.now(),
    );
  }
}
