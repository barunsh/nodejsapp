import 'package:flutter/material.dart';
import 'package:loginuicolors/dashboard.dart';
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
  runApp(MyApp(token: userToken, role: userRole));
}

class MyApp extends StatelessWidget {
  final token;
  final String? role;
  const MyApp({
    @required this.token,
    required this.role,
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
      initialRoute: (token != null && JwtDecoder.isExpired(token) == false) ? 'dashboard' : 'login',
      routes: {
        'login': (context) => MyLogin(),
        'register': (context) => MyRegister(),
        'dashboard': (context) => Dashboard(token: token, role: role ?? 'tenant'),
      },
    );
  }
}