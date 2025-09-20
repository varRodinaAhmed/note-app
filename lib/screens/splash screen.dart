import 'dart:async';

import 'package:business_card/colors/colors.dart';
import 'package:business_card/screens/home%20screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Get.off(HomeScreen()));
  }

  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: darkBlue,
      body: Center(
        child: Text(
          'DayFlow.',
          style: TextStyle(
              color: yellow, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
