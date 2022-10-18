import 'dart:io';

import 'package:eazy_shop/order/index.dart';
import 'package:eazy_shop/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      title: 'Rento Decor',
      home: SplashScreen(),
      routes: {'/orders': (context) => Order()},
      //home: ProfileInfo(),
    );
  }
}
