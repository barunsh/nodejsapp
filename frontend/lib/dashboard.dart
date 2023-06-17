import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loginuicolors/login.dart';

class Dashboard extends StatefulWidget {
  final token;
  final String? role;
  const Dashboard({@required this.token, required this.role, Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String email;
  String? role;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    role = jwtDecodedToken['role'];
  }

  Future<void> _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MyLogin()),
    );
  }

  Widget _buildDashboardContent() {
    if (widget.role == 'tenant') {
      return _buildTenantDashboard();
    } else if (widget.role == 'owner') {
      return _buildOwnerDashboard();
    } else {
      return Column( 
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
        Text('Invalid role'),
        SizedBox(height:20),
        _buildLogoutButton(),
        ],
      );
    }
  }

  Widget _buildTenantDashboard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome Tenant: $email'),
        // Add your Tenant specific widgets here.
        SizedBox(height: 20),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildOwnerDashboard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome Owner: $email'),
        // Add your Owner specific widgets here.
        SizedBox(height: 20),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return TextButton(
      onPressed: _logOut,
      child: Text('Log out', style: TextStyle(color: Colors.white)),
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildDashboardContent(),
      ),
    );
  }
}