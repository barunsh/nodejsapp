import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'config.dart';


class AddPropertyForm extends StatefulWidget {
  @override
  _AddPropertyFormState createState() => _AddPropertyFormState();
}

final DateFormat formatter = DateFormat('yyyy-MM-dd');

class _AddPropertyFormState extends State<AddPropertyForm> {
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _propertyAddressController = TextEditingController();
  TextEditingController _propertyRentController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedPropertyType = '';
  String _selectedImagePath = '';
  int _selectedBalcony = 1;
  int _selectedBedroom = 1;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImagePath = pickedImage.path;
      });
    }
  }

  void _submitForm() async {
  final String propertyName = _propertyNameController.text;
  final String propertyAddress = _propertyAddressController.text;
  final String propertyRent = _propertyRentController.text;
  final String propertyType = _selectedPropertyType;
  final String balconyCount = _selectedBalcony.toString();
  final String bedroomCount = _selectedBedroom.toString();
  final String propertyDate = formatter.format(_selectedDate!);

  final Map<String, String> requestBody = {
    'propertyName': propertyName,
    'propertyAddress': propertyAddress,
    'propertyRent': propertyRent,
    'propertyType': propertyType,
    'propertyBalconyCount': balconyCount,
    'propertyBedroomCount': bedroomCount,
    'propertyDate': propertyDate,
  };

  final encodedData = requestBody.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');

  final response = await http.post(
    Uri.parse('http://localhost:3000/bookings'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(requestBody),
  );


  if (response.statusCode == 200) {
    // Request successful, do something
    print('Form submitted successfully');
  } else {
    // Request failed, handle the error
    print('Form submission failed: ${response.reasonPhrase}');
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
                        controller: _propertyNameController,
                        decoration: InputDecoration(
                          labelText: 'Property Name',
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
                        controller: _propertyAddressController,
                        decoration: InputDecoration(
                          labelText: 'Property Address',
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
            const SizedBox(
              height: 20.0,
            ),
            // Text(
            //   'Property Image',
            //   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 10.0),
            // GestureDetector(
            //   onTap: _selectImage,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         color: Colors.grey,
            //         width: 100.0,
            //       ),
            //     ),
            //     child: _selectedImagePath.isNotEmpty
            //         ? Image.network(_selectedImagePath)
            //         : Container(
            //             height: 100.0,
            //             child: Icon(
            //               Icons.image,
            //               size: 50.0,
            //               color: Colors.grey,
            //             ),
            //           ),
            //   ),
            // ),
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
