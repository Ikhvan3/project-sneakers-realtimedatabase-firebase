import 'dart:async';

import 'package:flutter/material.dart';
import 'package:menu_makanan/screens/auth_page.dart';
import 'package:menu_makanan/screens/home_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 180,
              height: 180,
              child: Image.asset("images/logo_startscreen.png"),
            ),
            //SizedBox(height: 7),
            Text(
              'Waroeng Noesantara',
              style: TextStyle(
                color: Color.fromARGB(255, 177, 108, 43),
                fontSize: 24,
                fontFamily: 'Staatliches',
                //fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
