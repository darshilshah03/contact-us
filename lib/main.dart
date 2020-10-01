import 'package:contact_us/ContactUs.dart';
import 'package:flutter/material.dart';
import './ContactUs.dart';

void main() {
  runApp(MyApp());
}
//}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Us',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContactUs() 
    );
  }
}

