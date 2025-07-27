import 'package:flutter/material.dart';
import 'package:gymproject/HomeScreen/homeScreen.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Centered logo and text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 150,
                    height: 150,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/fitpro_logo.png', // Place your logo in assets and update the path.
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 16),
                  // App Name
                  Text(
                    'FitPro',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black38,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Bottom version and button
            Positioned(
              left: 0,
              right: 0,
              bottom: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'version 1.0.0',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      HomeScreen();
                      // Add your action hereH
                    },
                    child: Text("Action"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
