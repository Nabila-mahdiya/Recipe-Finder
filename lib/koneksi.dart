import 'dart:convert';
import 'package:projek_daily_booster/RecipeData.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = '16bb20c2f5cc47d799c9d2e7c3490662';
  final String baseUrl = 'https://api.spoonacular.com/recipes/random?number=10&apiKey=';

  Future<List<RecipeData>> getVegetarianRecipes() async {
    final Uri uri = Uri.parse('$baseUrl$apiKey&tags=vegetarian');
    return getRecipeData(uri.toString());
  }

  Future<List<RecipeData>> getVeganRecipes() async {
    final Uri uri = Uri.parse('$baseUrl$apiKey&tags=vegan');
    return getRecipeData(uri.toString());
  }

  Future<List<RecipeData>> getPopularRecipes() async {
    final Uri uri = Uri.parse('$baseUrl$apiKey&tags=dessert');
    return getRecipeData(uri.toString());
  }

  Future<List<RecipeData>> getHighProteinRecipes() async {
    final Uri uri = Uri.parse('$baseUrl$apiKey&tags=veryHealthy');
    return getRecipeData(uri.toString());
  }

  Future<List<RecipeData>> getRecipeData(String uri) async {
    try {
      http.Response result = await http.get(Uri.parse(uri));
      print('Request URL: ${uri.toString()}');
      print('Response Status Code: ${result.statusCode}');
      if (result.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(result.body);

        if (responseData.containsKey('recipes') && responseData['recipes'] != null) {
          List<dynamic> data = responseData['recipes'];
          List<RecipeData> recipes = [];

          for (var item in data) {
            if (item is Map<String, dynamic>) {
              recipes.add(RecipeData.fromJson(item));
            } else {
              print("Invalid data format for recipe: $item");
            }
          }

          return recipes;
        } else {
          print("API response is missing 'recipes' key or it's null.");
          throw Exception("Failed to load data");
        }
      } else {
        print("Fail: ${result.statusCode}");
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to load data");
    }
  }

 Future<List<RecipeData>> getRecipeDataWithTags(List<String> tags) async {
  try {
    // Construct the URI with tags as query parameters
    final Uri uri = Uri.parse('$baseUrl$apiKey&tags=${tags.join(',')}');

    // Fetch recipes using the modified URI
    List<RecipeData> recipesInCategory = await getRecipeData(uri.toString());

    // Filter recipes based on specified tags
    recipesInCategory = recipesInCategory.where((recipe) {
      return tags.every((tag) {
        switch (tag) {
          case 'vegetarian':
            return recipe.vegetarian == true;
          case 'vegan':
            return recipe.vegan == true;
          case 'veryPopular':
            return recipe.veryPopular == true;
          case 'veryHealthy':
            return recipe.veryHealthy == true;
          default:
            return true;
        }
      });
    }).toList();

    return recipesInCategory;
  } catch (e) {
    // Handle the error gracefully, for example, show a snackbar
    throw Exception("Failed to fetch recipes: $e");
  }
}
}


