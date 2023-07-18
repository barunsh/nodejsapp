import 'package:flutter/material.dart';
import '/dashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userToken = prefs.getString('token');
  final jwtDecodedToken = userToken != null ? JwtDecoder.decode(userToken) : null;
  final userRole = jwtDecodedToken != null ? jwtDecodedToken['role'] : null;
  final names = jwtDecodedToken != null ? jwtDecodedToken['names'] : null;
  final phone = jwtDecodedToken != null ? jwtDecodedToken['phone'] : null;

  print('JSON response: $jwtDecodedToken');
  runApp(MyApp(
    token: userToken,
    role: userRole,
    names: names != null ? names.toString() : null,
    phone: phone != null ? int.tryParse(phone.toString()) : null,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  final String? role;
  final String? names;
  final int? phone;
  final String? id;
  final String? email;

  const MyApp({
    required this.token,
    required this.role,
    this.id,
    this.email,
    this.names,
    this.phone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: (token != null && JwtDecoder.isExpired(token!) == false) ? 'dashboard' : 'login',
      routes: {
  'login': (context) => MyLogin(),
  'register': (context) => MyRegister(),
  'dashboard': (context) => Dashboard(
    token: token!,
    role: role!,
    names: names,
    phone: phone,
    id: id,
    email: email,
  ),
},
    );
  }
}


