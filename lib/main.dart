import 'package:flutter/material.dart';
import 'package:xiaoqi/config/size_fit.dart';
import 'package:xiaoqi/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TLSizeFit.initialize();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Darkness',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        accentColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}
