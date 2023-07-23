import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

// Your booking object with the propertyImage.data field
// For example, this could be the booking object you receive from the API
Map<String, dynamic> booking = {
  // Other booking properties...
  'propertyImage': {
    'data': 'base64-encoded-image-data', // Replace this with the actual base64-encoded image data
    'contentType': 'image/jpg',
  },
};

class DisplayImageFromBase64 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ensure that the base64-encoded image data is padded correctly
    String imageDataWithPadding = addBase64Padding(booking['propertyImage']['data']);
    // Decode the base64-encoded image data into bytes
    Uint8List imageBytes = base64Decode(imageDataWithPadding);

    return Scaffold(
      appBar: AppBar(
        title: Text('Display Image from Base64'),
      ),
      body: Center(
        // Use the Image.memory() widget to display the image
        child: Image.memory(
          imageBytes,
          fit: BoxFit.cover,
          width: 300,
          height: 300,
        ),
      ),
    );
  }

  String addBase64Padding(String base64String) {
    int paddingLength = 4 - (base64String.length % 4);
    return base64String + '=' * paddingLength;
  }
}

void main() {
  runApp(MaterialApp(
    home: DisplayImageFromBase64(),
  ));
}