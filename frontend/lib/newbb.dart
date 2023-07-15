import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    // id: json['_id'] ?? '',
    propertyName: json['propertyName'] ?? '',
    propertyAddress: json['propertyAddress'] ?? '',
    propertyRent: json['propertyRent'] ?? 0,
    propertyType: json['propertyType'] ?? '',
    propertyBalconyCount: json['propertyBalconyCount'] ?? 0,
    propertyBedroomCount: json['propertyBedroomCount'] ?? 0,
    propertyDate: json['propertyDate'] != null ? DateTime.parse(json['propertyDate']) : DateTime.now(),
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
    final response = await http.get(Uri.parse('http://localhost:3000/getbooking'));
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Page'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return CardList(
                  booking: booking,
                );
              },
            ),
    );
  }
}

class CardList extends StatelessWidget {
  final Booking booking;

  CardList({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(booking.propertyName),
            subtitle: Text(booking.propertyAddress),
            trailing: Text(booking.propertyRent.toString()),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Property Type: ${booking.propertyType}'),
                Text('Balcony Count: ${booking.propertyBalconyCount}'),
                Text('Bedroom Count: ${booking.propertyBedroomCount}'),
                Text('Property Date: ${booking.propertyDate}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
