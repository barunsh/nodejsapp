import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'updatepage.dart';
// import 'user.dart';

class User {
  final int id;
  final String names;
  final int phone;
  final String email;
  final String role;

  User({
    required this.id,
    required this.names,
    required this.phone,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      names: json['names'] ?? '',
      phone: json['phone'] ?? 0,
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class DeleteUpdate extends StatefulWidget {
  final String? id;
  final String? names;
  final String? email;
  final int? phone;

  DeleteUpdate({this.id, this.names, this.email, this.phone});

  @override
  _DeleteUpdateState createState() => _DeleteUpdateState();
}

class _DeleteUpdateState extends State<DeleteUpdate> {
  List<User> users = [];
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
      final response = await http.get(Uri.parse('http://localhost:3000/getuser'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == true && jsonData['users'] is List) {
          setState(() {
            users = (jsonData['users'] as List<dynamic>)
                .map((item) => User.fromJson(item))
                .toList();
          });
        } else {
          print('Invalid response format or no user data');
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
        title: Text('All Users'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserCard(user: user);
              },
            ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${user.id}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Names: ${user.names}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Phone: ${user.phone}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Email: ${user.email}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Role: ${user.role}',
              style: TextStyle(fontSize: 16),
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
                        builder: (context) => UpdateUserScreen (id: user.id,
        names: user.names,
        phone: user.phone,
        email: user.email,
        role: user.role,),
                      ),                      
                    );
                  },
                  child: Text('Update User'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
