import 'package:flutter/material.dart';
import 'package:loginuicolors/colors/colors.dart';
import '../screen/Tenantpages/Tenant_view.dart';
import '../screen/Tenantpages/aboutus.dart';
import '../screen/Tenantpages/postlisting.dart';
import '../screen/Tenantpages/search.dart';
import '../screen/Tenantpages/setting.dart';

class TenantBottombar extends StatefulWidget {
  const TenantBottombar({Key? key}) : super(key: key);

  @override
  State<TenantBottombar> createState() => _TenantBottombarState();
}

class _TenantBottombarState extends State<TenantBottombar> {
  int _currentIndex = 0;

  List<Widget> _buildScreens() {
    return [
      TenantViewPage(),
      Search(),
      PostListing(),
      AboutUs(),
      Setting(),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}
