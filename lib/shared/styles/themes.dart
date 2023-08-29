

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduateproject/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 15.0,
      color: Colors.black,
    ),
  ),
  // appBarTheme:  AppBarTheme(
  //     titleSpacing: 10,
  //     // backwardsCompatibility: false,
  //     systemOverlayStyle: SystemUiOverlayStyle(
  //       statusBarColor: defaultColorGray,
  //       statusBarIconBrightness: Brightness.dark,
  //     ),
  //     backgroundColor: defaultColorGreen,
  //     elevation: 5.0,
  //     titleTextStyle: TextStyle(
  //       color: defaultColorGray,
  //       fontSize: 20.0,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     iconTheme: IconThemeData(color: defaultColorGray)),
  scaffoldBackgroundColor: HexColor('#F7F7F7'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
);


