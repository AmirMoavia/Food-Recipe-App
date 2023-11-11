import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/Views/home_screen.dart';

class CustomSplashScreen extends StatefulWidget {
  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay to simulate the splash screen duration
    Timer(Duration(seconds: 4), () {
      // Navigate to the home screen or any other screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Customize the background color
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 83, 24, 24),
          Color.fromARGB(255, 0, 0, 0),
        ])),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/food.jpg'),
              ),

              // Customize the logo or use your own image
              SizedBox(height: 16.0),
              Text(
                'Moavia Develpor',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white, // Customize the text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
