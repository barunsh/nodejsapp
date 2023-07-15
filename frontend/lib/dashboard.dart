import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'addproperty.dart';
import 'showproperty.dart';

class Dashboard extends StatefulWidget {
  final String token;
  final String? role;

  const Dashboard({required this.token, required this.role, Key? key})
      : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String email;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  Future<void> _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MyLogin()),
    );
  }

  void _navigateToAddPropertyForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPropertyForm(
          token: widget.token,
          role: widget.role),
        ),
      );
  }

  void _navigateToShowPropertyForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GetDataPage(
          // token: widget.token,
          // role: widget.role,
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    if (widget.role == 'tenant') {
      return _buildTenantDashboard();
    } else if (widget.role == 'owner') {
      return _buildOwnerDashboard();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Invalid role'),
          SizedBox(height: 20),
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
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _navigateToAddPropertyForm,
          child: Text('Add Property'),
        ),
        ElevatedButton(
          onPressed: _navigateToShowPropertyForm,
          child: Text('Show Property'),
        ),
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
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _navigateToAddPropertyForm,
          child: Text('Add Property'),
        ),
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

