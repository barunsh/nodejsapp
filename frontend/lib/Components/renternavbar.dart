import 'package:flutter/material.dart';

class OwnerBottomBar extends StatefulWidget {
  const OwnerBottomBar({Key? key}) : super(key: key);

  @override
  State<OwnerBottomBar> createState() => _OwnerBottomBarState();
}

class _OwnerBottomBarState extends State<OwnerBottomBar> {
  int _currentIndex = 0;
  List<Widget> _buildScreens() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens()[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 69, 101, 95),
          selectedItemColor: Colors.teal,
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
