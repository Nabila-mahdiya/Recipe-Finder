import 'package:flutter/material.dart';
import 'RecipeData.dart';
import 'package:google_fonts/google_fonts.dart';

class Recipedetailpage extends StatelessWidget {
  final RecipeData recipe;

  Recipedetailpage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: Text(
          recipe.title,
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 2.0), // Sesuaikan jarak yang diinginkan
        child: RecipeDetailContent(recipe: recipe),
      ),
    );
  }
}

class RecipeDetailContent extends StatefulWidget {
  final RecipeData recipe;

  RecipeDetailContent({required this.recipe});

  @override
  _RecipeDetailContentState createState() => _RecipeDetailContentState();
}

class _RecipeDetailContentState extends State<RecipeDetailContent> {
  bool showFullIngredients = false;
  bool showFullInstructions = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
  children: [
    ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50.0),
        bottomRight: Radius.circular(50.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 255, 143, 0),
            width: 1.0,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
        ),
        child: Image.network(
          widget.recipe.image,
          width: double.infinity,
          height: 290,
          fit: BoxFit.contain,
        ),
      ),
    ),
    
  ],
),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Cooking Time: ${widget.recipe.readyInMinutes} minutes',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Category: ${widget.recipe.dishTypes.join(", ")}',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Ingredients:',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.recipe.extendedIngredients
                      .asMap()
                      .entries
                      .where((entry) => showFullIngredients || entry.key < 2)
                      .map(
                        (entry) => Text(
                          '${entry.key + 1}. ${entry.value.name} - ${entry.value.amount} ${entry.value.unit}',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                      .toList(),
                ),
                if (widget.recipe.extendedIngredients.length > 2)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showFullIngredients = !showFullIngredients;
                      });
                    },
                    child: Text(
                      showFullIngredients ? 'Show less' : 'Show more',
                      style: TextStyle(
                        color: Color(0xFFFFC36B),
                      ),
                    ),
                  ),
                Text(
                  'Instructions:',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.recipe.instructions
                      .split('\n')
                      .asMap()
                      .entries
                      .where((entry) => showFullInstructions || entry.key < 2)
                      .map(
                        (entry) => Text(
                          '${entry.key + 1}. ${entry.value}',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                      .toList(),
                ),
                if (widget.recipe.instructions.split('\n').length > 1)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showFullInstructions = !showFullInstructions;
                      });
                    },
                    child: Text(
                      showFullInstructions ? 'Show less' : 'Show more',
                      style: TextStyle(
                        color: Color(0xFFFFC36B),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
        );
      
  }
}

