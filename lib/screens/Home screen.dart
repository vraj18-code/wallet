import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    ProfileScreen(),
    WalletScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                onTabTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Wallet'),
              onTap: () {
                onTabTapped(1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _children[_currentIndex],
    );
  }
}
