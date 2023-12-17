import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projek_daily_booster/homepage.dart';
import 'homepage.dart';

// void main() => runApp(MyApp());

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
        
          children: <Widget>[
            Image.asset(
              'images/ibu_bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Recipe Finder',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'Discover Endless Culinary Possibilities',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 340),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi yang akan dilakukan saat tombol ditekan
                      Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  HomePage(selectedIndex: 0)),
                                  );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD76249),
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 25),
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


