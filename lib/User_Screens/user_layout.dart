import 'package:coffee_shop_app/User_Screens/favorites_screen.dart';
import 'package:coffee_shop_app/User_Screens/home_screen.dart';
import 'package:coffee_shop_app/User_Screens/login_screen.dart';
import 'package:coffee_shop_app/User_Screens/search_screen.dart';
import 'package:coffee_shop_app/User_Screens/write_message_screen.dart';
import 'package:coffee_shop_app/shared/database.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class UserLayout extends StatefulWidget {
  // const UserLayout({Key? key}) : super(key: key);

  @override
  _UserLayoutState createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  List<String> appBarTitle = [
    'Search',
    'Your Favorite Drinks',
    'Write a message',
  ];

  List<Widget> pages = [
    HomeScreen(Database.currentUser),
    SearchScreen(Database.currentUser),
    FavoriteDrinksScreen(Database.currentUser),
    WriteMessageScreen(),
  ];

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: pageIndex == 0
          ? null
          : AppBar(
              title: Text(
                appBarTitle[pageIndex - 1],
                style: TextStyle(color: Colors.brown),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                TextButton(
                    onPressed: () {
                      Database.userLogOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Column(
                      children: [
                        Icon(Icons.exit_to_app_outlined),
                        Text('Sign Out'),
                      ],
                    ))
              ],
            ),
      body: pages[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.brown,
        index: pageIndex,
        height: 45,
        items: <Widget>[
          Icon(Icons.home_filled, size: 30, color: Colors.brown),
          Icon(Icons.search, size: 30, color: Colors.brown),
          Icon(Icons.favorite, size: 30, color: Colors.brown),
          Icon(Icons.message, size: 30, color: Colors.brown),
        ],
        onTap: (index) {
          setState(
            () {
              print(index);

              pageIndex = index;
            },
          );
        },
      ),
    );
  }
}
