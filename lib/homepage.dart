import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'koneksi.dart';
import 'RecipeData.dart';
import 'Profile.dart';
import 'Recipedetailpage.dart';
import 'Recipelist.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;

  HomePage({required this.selectedIndex});

  @override
  _HomePageState createState() => _HomePageState(selectedIndex: selectedIndex);
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  String loadingMessage = '';
  int _selectedIndex = 0;

  _HomePageState({required int selectedIndex}) : _selectedIndex = selectedIndex;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/recipeList');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  late List<RecipeData> vegetarianRecipes = [];
  late List<RecipeData> veganRecipes = [];
  late List<RecipeData> popularRecipes = [];
  late List<RecipeData> highProteinRecipes = [];

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    try {
      setState(() {
        isLoading = true;
        loadingMessage = 'Fetching recipes...';
      });
      ApiService apiService = ApiService();

      vegetarianRecipes = await apiService.getVegetarianRecipes();
      veganRecipes = await apiService.getVeganRecipes();
      popularRecipes = await apiService.getPopularRecipes();
      highProteinRecipes = await apiService.getHighProteinRecipes();

      setState(() {
        isLoading = false;
        loadingMessage = '';
      });
    } catch (e) {
      // Handle error
      print('Error fetching recipes: $e');
      setState(() {
        isLoading = false;
        loadingMessage =
            'Failed to fetch recipes. Please check your internet connection and try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'What do you want to cook today?',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 19.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      // SizedBox(height: 30);
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategorySection('Category Vegetarian', vegetarianRecipes),
                      CategorySection('Category Vegan', veganRecipes),
                      CategorySection('Category Dessert', popularRecipes),
                      // CategorySection('High Protein', highProteinRecipes),
                    ],
                  ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<RecipeData> recipes;

  CategorySection(this.title, this.recipes);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: GoogleFonts.playfairDisplay(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 3, 3)),
            )),
        Container(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to the detail page when a recipe is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Recipedetailpage(recipe: recipes[index]),
                    ),
                  );
                },
                child: Container(
                  width: 140,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(recipes[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        recipes[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
