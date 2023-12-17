import 'dart:convert';

class RecipeData {
  int id; 
  String title;
  int readyInMinutes;
  String sourceUrl;
  String image;
  String imageType;
  String summary;
  String spoonacularSourceUrl;
   List<String> dishTypes;
  List<String> occasions;
  String instructions;
  List<ExtendedIngredient> extendedIngredients; 
  bool vegetarian;
  bool vegan;
  bool veryPopular;
  bool veryHealthy;

  RecipeData({
    required this.id,
    required this.title,
    required this.readyInMinutes,
    required this.sourceUrl,
    required this.image,
    required this.imageType,
    required this.summary,
    required this.spoonacularSourceUrl,
    required this.dishTypes,
    required this.occasions,
    required this.instructions,
    required this.extendedIngredients,
    required this.vegetarian,
    required this.vegan,
    required this.veryPopular,
    required this.veryHealthy,
  });

  factory RecipeData.fromJson(Map<String, dynamic> json) {
    return RecipeData(
      id: json['id'],
      title: json['title'] ?? '',
      readyInMinutes: json['readyInMinutes'] ?? 0,
      sourceUrl: json['sourceUrl']?? '',
      image: json['image']?? '',
      imageType: json['imageType']?? '',
      summary: json['summary']?? '',
      spoonacularSourceUrl: json['spoonacularSourceUrl']?? '',
      dishTypes: List<String>.from(json['dishTypes']),
      occasions: List<String>.from(json['occasions']),
      instructions: json['instructions'],
      extendedIngredients: List<ExtendedIngredient>.from(
        json['extendedIngredients'].map(
          (item) => ExtendedIngredient.fromJson(item),
        ),
      ),
      vegetarian: json['vegetarian']?? false,
      vegan: json['vegan']?? false,
      veryPopular: json['veryPopular']?? false,
      veryHealthy: json['veryHealthy']?? false,
    );
  }
}

class ExtendedIngredient {
  int id;
  String aisle;
  String image;
  String consistency;
  String name;
  String nameClean;
  String original;
  String originalName;
  double amount;
  String unit;
  List<String> meta;

  ExtendedIngredient({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.meta,
  });

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredient(
      id: json['id'],
      aisle: json['aisle'],
      image: json['image'],
      consistency: json['consistency'],
      name: json['name'],
      nameClean: json['nameClean'],
      original: json['original'],
      originalName: json['originalName'],
      amount: json['amount'],
      unit: json['unit'],
      meta: List<String>.from(json['meta']),
    );
  }
}


