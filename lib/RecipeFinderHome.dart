import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'RecipeData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Recipedetailpage.dart';
import 'RecipeListByCategory.dart';

// void main() => runApp(MyApp());

class Recipe {
  final String title;
  final String imageUrl;
  final int cookTime;
  final String category;

  Recipe(
      {this.title = '',
      this.imageUrl = '',
      this.cookTime = 0,
      this.category = ''});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecipeFinderHome(),
    );
  }
}

class RecipeFinderHome extends StatefulWidget {
  @override
  _RecipeFinderHomeState createState() => _RecipeFinderHomeState();
}

class _RecipeFinderHomeState extends State<RecipeFinderHome> {
  List<RecipeData> recipes = RecipeData.recipes;
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
  }
//   _RecipeFinderHomeState createState() => _RecipeFinderHomeState();
// }

// class _RecipeFinderHomeState extends State<RecipeFinderHome> {
//   List<Recipe> recipes = [];
//   String selectedCategory = '';

//   Future<void> fetchRecipes() async {
//     final Uri url = Uri.parse(
//         'https://api.spoonacular.com/recipes/random?number=10&apiKey=16bb20c2f5cc47d799c9d2e7c3490662');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final recipeList = data['recipes'] as List<dynamic>;

//       setState(() {
//         recipes = recipeList
//             .map((recipeData) => Recipe(
//                   title: recipeData['title'],
//                   imageUrl: recipeData['image'],
//                   cookTime: recipeData['readyInMinutes'],
//                 ))
//             .toList();
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchRecipes();
//   }

  @override
  Widget build(BuildContext context) {
    List<RecipeData> filteredRecipes = selectedCategory.isEmpty
        ? recipes
        : recipes
            .where((recipe) => recipe.category == selectedCategory)
            .toList();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: null,
        actions: <Widget>[
          Builder(
            builder: (context) => InkWell(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Container(
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFFFC36B), // Warna border
                    width: 2.0, // Lebar border
                  ),
                ),
                child: CircleAvatar(
                 backgroundImage: AssetImage('images/profil.jpg'),
                  radius: 30,
                ),
              ),
            ),
          ),
        ],
        flexibleSpace: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'What do you want to cook today?',
              style: GoogleFonts.playfairDisplay(
                fontSize: 16.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFFFC36B),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for recipes',
                    contentPadding: EdgeInsets.all(12.0),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFFFFC36B),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Recipes by Category',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: buildCategoryItem(
                      'Breakfast Recipes',
                      Icons.breakfast_dining,
                      'Breakfast Recipes', // Tambahkan parameter ini
                    ),
                  ),
                  SizedBox(width: 16),
                  buildCategoryItem(
                    'Lunch Recipes',
                    Icons.lunch_dining,
                    'Lunch Recipes', // Tambahkan parameter ini
                  ),
                  SizedBox(width: 16),
                  buildCategoryItem(
                    'Dinner Recipes',
                    Icons.dinner_dining,
                    'Dinner Recipes', // Tambahkan parameter ini
                  ),
                  SizedBox(width: 16),
                  buildCategoryItem(
                    'Cake recipes',
                    Icons.cake,
                    'Cake recipes', // Tambahkan parameter ini
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Random Recipes',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return Card(
                        elevation:
                            3, // Atur tingkat elevasi sesuai keinginan Anda
                        margin: EdgeInsets.all(6),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: recipe.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          title: Text(
                            recipe.title,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            'Cook Time: ${recipe.cookTime} minutes',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 15,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Recipedetailpage(recipe: recipes[index])),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Menu Item 1'),
              onTap: () {
                // Handle menu item 1
              },
            ),
            ListTile(
              title: Text('Menu Item 2'),
              onTap: () {
                // Handle menu item 2
              },
            ),
          ],
        ),
      ),
    );
  }

  void navigateToRecipeList(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeListByCategory(category: category),
      ),
    );
  }

// Widget buildCategoryItem(String title, IconData icon, String category) {
//   return GestureDetector(
//     onTap: () {
//       navigateToRecipeList(category);
//     },
//     child: Column(
//       children: [
//         Icon(
//           icon,
//           size: 50,
//           color: Colors.blue,
//         ),
//         Text(title),
//       ],
//     ),
//   );
// }

  Widget buildCategoryItem(String title, IconData icon, String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          navigateToRecipeList(category);
          selectedCategory = title;
        });
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFC36B),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
