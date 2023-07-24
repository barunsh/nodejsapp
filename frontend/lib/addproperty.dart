import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:majorproject/showimage.dart';
import 'config.dart';
import 'user.dart';

class AddPropertyForm extends StatefulWidget {
  final String? id;
  final String? names;
  final String? email;
  final String? phone;
  final String? token;
  final String? role;

  AddPropertyForm({required this.id, required this.names,required this.email,required this.phone, required this.token, required this.role});

  @override
  _AddPropertyFormState createState() => _AddPropertyFormState();
}


final DateFormat formatter = DateFormat('yyyy-MM-dd');

class _AddPropertyFormState extends State<AddPropertyForm> {
  TextEditingController _propertyAddressController = TextEditingController();
  TextEditingController _propertyLocalityController = TextEditingController();
  TextEditingController _propertyRentController = TextEditingController();
  TextEditingController _bookingRemainingController = TextEditingController();
  TextEditingController _propertyImageController = TextEditingController(); // New TextEditingController
  DateTime? _selectedDate;
  String _selectedPropertyType = '';
  int _selectedBalcony = 1;
  int _selectedBedroom = 1;
  File? _propertyImage;

  
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a date')),
        );
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _selectImage() async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage == null) {
        return;
      }

      setState(() {
        _propertyImage = File(pickedImage.path);
        _propertyImageController.text = pickedImage.path;
      });
      print('selected image path: ${pickedImage.path}');
      print('selected image file: $pickedImage');
    } catch (e) {
      print('Error selecting image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting image. Please try again')),
      );
    }
  }

  void _submitForm() async {
    final String propertyAddress = _propertyAddressController.text;
    final String propertyLocality = _propertyLocalityController.text;
    final String propertyRent = _propertyRentController.text;
    final String bookingRemaining = _bookingRemainingController.text;
    final String propertyType = _selectedPropertyType;
    final String balconyCount = _selectedBalcony.toString();
    final String bedroomCount = _selectedBedroom.toString();
    final String propertyDate = _selectedDate != null ? formatter.format(_selectedDate!) : '';
  
    String imageBase64 = '';

    if (widget.names == null || widget.names!.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Owner name is missing or empty')),
    );
    return;
  }
    if (_propertyImage != null) {
      try {
        List<int> imageBytes = await _propertyImage!.readAsBytes();
        imageBase64 = base64Encode(imageBytes);
      } catch (e) {
        print('Error converting image to base64: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image. Please try again.')),
        );
        return;
      }
    }

    if (widget.names!.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Owner name is missing or empty')),
    );
    return;
  }
    
    
    
    if (widget.names == null || widget.names!.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Owner name is missing or empty')),
    );
    return;
  }

    if (propertyAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter property address')),
      );
      return;
    }

    if (propertyLocality.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter property locality')),
      );
      return;
    }

    if (propertyRent.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter property rent')),
      );
      return;
    }

    if (propertyType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a property type')),
      );
      return;
    }
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date')),
      );
      return;
    }
    print(widget.names);
    final Map<String, dynamic> requestBody = {
      'propertyAddress': propertyAddress,
      'ownerId': widget.id,
      'ownerName': widget.names,
      'propertyLocality': propertyLocality,
      'propertyRent': propertyRent,
      'propertyType': propertyType,
      'bookingRemaining': bookingRemaining,
      'propertyBalconyCount': balconyCount,
      'propertyBedroomCount': bedroomCount,
      'propertyDate': propertyDate,
      'propertyImageBase64': imageBase64,
    };


    final response = await http.post(
      Uri.parse('$createProperty'),
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
            content: Text('Property successfully added'),
            duration: Duration(seconds: 3),
          ),
        );

        // Call uploadImage with the newly created property ID
        final propertyId = jsonResponse['property']['_id']; 
        // print(bookingId);// Assuming the response has the booking ID
        await _uploadImage(propertyId);
        print(propertyId);

        Navigator.pushNamed(
          context,
          'dashboard',
          arguments: {
            'token': widget.token!,
            'role': widget.role!,
            'phone': widget.phone,
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add property')),
        );
      }
    } else {
      print('Server responded with status code ${response.statusCode}');
    }
  }

  Future<void> _uploadImage(String propertyId) async {
    try {
      final imageBytes = await _propertyImage!.readAsBytes();
      final imageBase64 = base64Encode(imageBytes);

      final requestBody = {
        'propertyId': propertyId,
        'imageBase64': imageBase64,
      };

      final response = await http.post(
        Uri.parse('$uploadImage'), // Replace with the correct backend API endpoint for image upload
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image')),
        );
      }
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image. Please try again')),
      );
    }
  }

  Container _buildPropertyTypeContainer(
      String type, IconData iconData, bool isSelected) {
    return Container(
      
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Icon(
            iconData,
            size: 30.0,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(height: 5.0),
          Text(
            type,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
                  'Names: ${widget.names ?? 'N/A'}',
                  style: TextStyle(fontSize: 10),
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property Type',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPropertyType = 'home';
                      });
                    },
                    child: _buildPropertyTypeContainer(
                      'Home',
                      Icons.home,
                      _selectedPropertyType == 'home',
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPropertyType = 'apartment';
                      });
                    },
                    child: _buildPropertyTypeContainer(
                      'Apartment',
                      Icons.apartment,
                      _selectedPropertyType == 'apartment',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                'Property Details',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextField(
                        controller: _propertyAddressController,
                        decoration: InputDecoration(
                          labelText: 'Property Address',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextField(
                        controller: _propertyLocalityController,
                        decoration: InputDecoration(
                          labelText: 'Property Locality',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                "Balcony",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  int number = index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBalcony = number;
                      });
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedBalcony == number
                              ? Colors.blue
                              : Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Text(
                          number.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: _selectedBalcony == number
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _selectedBalcony == number
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Bedrooms",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  int number = index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBedroom = number;
                      });
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedBedroom == number
                              ? Colors.blue
                              : Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Text(
                          number.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: _selectedBedroom == number
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _selectedBedroom == number
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Property Rent',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextField(
                  controller: _propertyRentController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Rent Amount',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Property Rented Date',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(
                      Icons.calendar_month,
                      size: 50,
                    ),
                  ),
                ],
              ),
              // Text(
              //   'Booking Remaining',
              //   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 10.0),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.grey,
              //       width: 1.0,
              //     ),
              //     borderRadius: BorderRadius.circular(5.0),
              //   ),
              //   child: TextField(
              //     controller: _bookingRemainingController,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //       labelText: 'Booking Remaining',
              //       border: InputBorder.none,
              //       contentPadding: EdgeInsets.all(10.0),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _selectImage,
                child: Text('Upload Image'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(12),
                ),
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}