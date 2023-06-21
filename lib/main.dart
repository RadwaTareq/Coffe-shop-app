import 'package:coffee_shop_app/Admin_Screens/add_new_product_screen.dart';
import 'package:coffee_shop_app/Admin_Screens/admin_screen.dart';
import 'package:coffee_shop_app/Admin_Screens/update_product_screen.dart';
import 'package:coffee_shop_app/User_Screens/login_screen.dart';
import 'package:coffee_shop_app/User_Screens/register_screen.dart';
import 'package:coffee_shop_app/User_Screens/write_message_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown, buttonColor: Colors.brown),
      initialRoute: 'Login Screen',
      routes: {
        'Login Screen': (BuildContext context) => Login(),
        'Registration Screen': (BuildContext context) => Registration(),
        'Write Message Screen': (BuildContext context) => WriteMessageScreen(),
        'Admin Screen': (BuildContext context) => AdminPanel(),
        'Add New Product Screen': (BuildContext context) =>
            AddNewProductScreen(),
        'Update Product Screen': (BuildContext context) =>
            UpdateProductScreen(),
      },
    );
  }
}
