import 'package:flutter/material.dart';

class PostListing extends StatelessWidget {
  const PostListing({Key? key}) : super(key: key);
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
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            CardWidget(
              image: AssetImage('assets/modern.jpg'),
              amount: 'Rs. 5000',
              title: 'Kathmandu',
              description: 'Kirtipur, Kathmandu',
            ),
            CardWidget(
              image: AssetImage('assets/modern.jpg'),
              amount: 'Rs. 5000',
              title: 'Kathmandu',
              description: 'Kirtipur, Kathmandu',
            ),
            CardWidget(
              image: AssetImage('assets/modern.jpg'),
              amount: 'Rs. 5000',
              title: 'Kathmandu',
              description: 'Kirtipur, Kathmandu',
            ),
            CardWidget(
              image: AssetImage('assets/modern.jpg'),
              amount: 'Rs. 5000',
              title: 'Kathmandu',
              description: 'Kirtipur, Kathmandu',
            ),
            CardWidget(
              image: AssetImage('assets/modern.jpg'),
              amount: 'Rs. 5000',
              title: 'Kathmandu',
              description: 'Kirtipur, Kathmandu',
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final ImageProvider image;
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
        ));
  }
}
