import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'bookingdetails.dart';


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
  TextEditingController searchController = TextEditingController();

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

  List<String> searchBookings(String pattern) {
    return bookings
        .where((booking) =>
            booking.propertyName.toLowerCase().contains(pattern.toLowerCase()) ||
            booking.propertyAddress.toLowerCase().contains(pattern.toLowerCase()))
        .map((booking) => booking.propertyName)
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🏚️All Properties'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TypeAheadField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: searchController,
                      onChanged: (value){
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return searchBookings(pattern);
                      },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      searchController.text = suggestion;
                    },
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      constraints: BoxConstraints(maxHeight: 210.0),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      final searchPattern = searchController.text.toLowerCase();
                      if (searchPattern.isNotEmpty &&
                          !booking.propertyName.toLowerCase().contains(searchPattern) &&
                          !booking.propertyAddress.toLowerCase().contains(searchPattern)) {
                        return Container();
                      }
                      return CardList(
                        booking: booking,
                      );
                    },
                  ),
                ),
              ],
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price: Rs. ${booking.propertyRent}'),
                Text('Address: ${booking.propertyAddress}'),
              ],
            ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetails(booking:booking),
                  ),
                  );
                },
                child: Text('ℹ️ Get Information'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                onPressed: () {
                  // Handle second button press
                },
                child: Text('📅 Book Now'),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

