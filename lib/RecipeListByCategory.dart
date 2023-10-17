import 'RecipeData.dart';
import 'Recipedetailpage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';


class RecipeListByCategory extends StatefulWidget {
  final String category;

  RecipeListByCategory({required this.category});

  @override
  _RecipeListByCategoryState createState() => _RecipeListByCategoryState();
}

class _RecipeListByCategoryState extends State<RecipeListByCategory> {
  List<RecipeData> recipes = RecipeData.recipes;

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = recipes
        .where((recipe) => recipe.category == widget.category)
        .toList();

    return Scaffold(
      appBar: AppBar(
       backgroundColor: Color(0xFFFFC36B),
        title: Text(widget.category,
         style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            color: Colors.white,),
      ),
      ),
      
      body: GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.8, // Jumlah kolom dalam grid
  ),
  itemCount: filteredRecipes.length,
  itemBuilder: (context, index) {
    final recipe = filteredRecipes[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Recipedetailpage(recipe: recipe),
          ),
        );
      },
      child: Card(
        
          elevation: 5, // Atur tingkat elevasi sesuai keinginan Anda
      // margin: EdgeInsets.all(8),
          
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: recipe.imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            ListTile(
              title: Text(
                recipe.title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                'Cook Time: ${recipe.cookTime} minutes',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 12,
                ),
              ),
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

