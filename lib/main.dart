import 'package:flutter/material.dart';
import 'package:projek_daily_booster/Profile.dart';
import 'package:projek_daily_booster/Recipelist.dart';
import 'package:projek_daily_booster/homepage.dart';
import 'login.dart'; 


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login(), 
      routes: {
        '/home': (context) => HomePage(selectedIndex: 0),
        '/recipeList': (context) => RecipeList(selectedIndex: 1),
        '/profile': (context) => Profile(selectedIndex: 2),
      },
    );
  }
}

