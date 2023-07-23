import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'property.dart';
import 'bookingpage.dart';

class GetDataPage extends StatefulWidget {
  final String? id;
  final String? names;
  final String? email;
  final String? phone;

  GetDataPage({required this.id, required this.names,required this.email,required this.phone});

  @override
  _GetDataPageState createState() => _GetDataPageState();
}


class _GetDataPageState extends State<GetDataPage> {
  List<Property> properties = [];
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
      final response = await http.get(Uri.parse('http://localhost:3000/getProperty'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == true && jsonData['property'] is List) {
          setState(() {
            properties = (jsonData['property'] as List<dynamic>)
                .map((item) => Property.fromJson(item))
                .toList();
          });
        } else {
          print('Invalid response format or no property data');
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

  List<String> searchProperties(String pattern) {
    return properties
        .where((property) =>
            property.propertyAddress.toLowerCase().contains(pattern.toLowerCase()) ||
            property.propertyLocality.toLowerCase().contains(pattern.toLowerCase()))
        .map((property) => property.propertyAddress)
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
                Text(
                  'ID: ${widget.id ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Names: ${widget.names ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Email: ${widget.email ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Phone: ${widget.phone ?? 'N/A'}',
                  style: TextStyle(fontSize: 16),
                ), 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TypeAheadField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return searchProperties(pattern);
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
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      final property = properties[index];
                      final searchPattern = searchController.text.toLowerCase();
                      if (searchPattern.isNotEmpty &&
                          !property.propertyAddress.toLowerCase().contains(searchPattern) &&
                          !property.propertyLocality.toLowerCase().contains(searchPattern)) {
                        return Container();
                      }
                      return CardList(
                        id: widget.id,
                        property: property,
                        names: widget.names,
                        email: widget.email,
                        phone: widget.phone,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class CardList extends StatefulWidget {
  final Property property;
  final String? names;
  final String? email;
  final String? phone;
  final String? id;

  CardList({required this.property, this.id, this.email, this.names, this.phone});

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool isBookingFull = false;

  @override
  void initState() {
    super.initState();
    checkBookingFull();
  }

  void checkBookingFull() {
    if (widget.property.bookingRemaining <= 0) {
      setState(() {
        isBookingFull = true;
      });
    } else {
      setState(() {
        isBookingFull = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(widget.property.propertyAddress),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: Rs. ${widget.property.propertyRent}'),
                    Text('Address: ${widget.property.propertyLocality}'),
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
                          builder: (context) => BookingPage(property: widget.property, names: widget.names, id: widget.id),
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
                      if (!isBookingFull) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPage(
                              property: widget.property,
                              names: widget.names,
                              email: widget.email,
                              phone: widget.phone,
                              id: widget.id,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('📅 Book Now'),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
          if (isBookingFull)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.red,
                child: Text(
                  'Booking Full',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}