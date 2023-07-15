import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loginuicolors/screen/Tenantpages/aboutus.dart';
import 'package:loginuicolors/screen/Tenantpages/postlisting.dart';
import 'package:loginuicolors/screen/Tenantpages/search.dart';
import 'package:loginuicolors/screen/Tenantpages/setting.dart';
import 'package:loginuicolors/screen/Tenantpages/tenant_view.dart';
import 'package:loginuicolors/utils/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors/colors.dart';
import 'login.dart';
import 'add_property_form.dart';

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
  late String names;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    names = jwtDecodedToken['names'];

    print(jwtDecodedToken);
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
    List<Widget> _buildScreens() {
      return [
        TenantViewPage(),
        Search(),
        PostListing(),
        AboutUs(),
        Setting(),
      ];
    }

    return Scaffold(
      body: _buildScreens()[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 69, 101, 95),
          selectedItemColor: tdpurple3,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_outlined),
              label: "Post Listing",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "About us",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
        ),
      ),
      // Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text('Welcome Tenant: $email'),
      //         SizedBox(height: 20),
      //         ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => TenantViewPage(),
      //                 ));
      //           },
      //           child: Text('Add Property'),
      //         ),
      //         SizedBox(height: 20),
      //         _buildLogoutButton(),
      //       ],
      //     ),
      //   ),
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
    return _buildDashboardContent();
  }
}
