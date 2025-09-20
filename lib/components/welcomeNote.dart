import 'dart:ui';

import 'package:business_card/colors/colors.dart';
import 'package:business_card/screens/home%20screen.dart';
import 'package:flutter/material.dart';

class welcomeNote extends StatelessWidget {
  const welcomeNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 180,
              width: 350,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: shadow,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 3))
                ],
                borderRadius: BorderRadius.circular(20),
                color: darkGreen,
                image: DecorationImage(
                    image: AssetImage(
                      'assets/photo2.png',
                    ),
                    fit: BoxFit.cover),
              ),
            )),
        Positioned(
          left: 10,
          top: 25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, there!',
                style: TextStyle(
                    color: white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'What do you think today?',
                style: TextStyle(color: white, fontSize: 14),
              ),
            ],
          ),
        )
      ],
    );
  }
}
