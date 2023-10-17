import 'package:flutter/material.dart';
import 'package:projek_daily_booster/RecipeFinderHome.dart';
import 'login.dart'; // Import kelas login


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecipeFinderHome(), // Gunakan LoginPage sebagai home screen
    );
  }
}

