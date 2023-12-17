import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'koneksi.dart';
import 'RecipeData.dart';
import 'Profile.dart';
import 'Recipedetailpage.dart';
import 'homepage.dart';

class RecipeList extends StatefulWidget {
  final int selectedIndex;

  RecipeList({required this.selectedIndex});
  @override
  _RecipeListState createState() =>
      _RecipeListState(selectedIndex: selectedIndex);
}

class _RecipeListState extends State<RecipeList> {
  String loadingMessage = '';
  int _selectedIndex = 0;
  _RecipeListState({required int selectedIndex})
      : _selectedIndex = selectedIndex;
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

  late List<RecipeData> allRecipes = [];
  late List<RecipeData> displayedRecipes = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllRecipes();
  }

  Future<void> loadAllRecipes() async {
    try {
      ApiService apiService = ApiService();

      // Fetch recipes from different categories
      List<RecipeData> vegetarianRecipes =
          await apiService.getVegetarianRecipes();
      List<RecipeData> dessertRecipes = await apiService.getPopularRecipes();
      List<RecipeData> veganRecipes = await apiService.getVeganRecipes();

      // Combine the lists and shuffle them
      allRecipes = [...vegetarianRecipes, ...dessertRecipes, ...veganRecipes]
        ..shuffle();

      // Set displayedRecipes to allRecipes initially
      setState(() {
        displayedRecipes = allRecipes;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching recipes: $e');
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchRecipes(String query) {
    query = query.toLowerCase();
    setState(() {
      displayedRecipes = allRecipes
          .where((recipe) =>
              recipe.title.toLowerCase().contains(query) ||
              recipe.extendedIngredients.any((ingredient) =>
                  ingredient.name.toLowerCase().contains(query)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe List',
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.amber[800],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RecipeSearchDelegate(allRecipes),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'All Recipes',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildRecipeList(),
                  buildRecipeListView(),
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

  Widget buildRecipeList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: displayedRecipes.length,
      itemBuilder: (context, index) {
        final recipe = displayedRecipes[index];
        return Card(
          elevation: 3,
          margin: EdgeInsets.all(6),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: recipe.image,
              width: 60,
              height: 90,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(
              recipe.title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 15,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.alarm),
                Text(
                  '${recipe.readyInMinutes} minutes',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Recipedetailpage(recipe: recipe),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildRecipeListView() {
    return Container(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: displayedRecipes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Recipedetailpage(recipe: displayedRecipes[index]),
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
                        image: NetworkImage(
                          displayedRecipes[index].image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    displayedRecipes[index].title,
                    style: TextStyle(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecipeSearchDelegate extends SearchDelegate {
  final List<RecipeData> recipes;

  RecipeSearchDelegate(this.recipes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement if needed
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : recipes
            .where((recipe) =>
                recipe.title.toLowerCase().contains(query.toLowerCase()) ||
                recipe.extendedIngredients.any((ingredient) =>
                    ingredient.name.toLowerCase().contains(query)))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].title),
          onTap: () {
            // Perform action when suggestion is selected
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Recipedetailpage(recipe: suggestionList[index]),
              ),
            );
          },
        );
      },
    );
  }
}
