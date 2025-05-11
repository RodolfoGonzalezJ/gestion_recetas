import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/inventory/services/inventory_service.dart';
import 'package:gestion_recetas/features/recipes/services/recipe_service.dart';

class DataProvider with ChangeNotifier {
  final InventoryService _inventoryService = InventoryService();
  final RecipeService _recipeService = RecipeService();

  List<dynamic> _recipes = [];
  List<dynamic> _products = [];
  int _totalRecipes = 0;
  int _criticalCount = 0;
  int _mediumCount = 0;

  List<dynamic> get recipes => _recipes;
  List<dynamic> get products => _products;
  int get totalRecipes => _totalRecipes;
  int get criticalCount => _criticalCount;
  int get mediumCount => _mediumCount;

  Future<void> loadRecipes() async {
    _recipes = await _recipeService.fetchRecipes();
    _totalRecipes = _recipes.length;
    notifyListeners();
  }

  Future<void> loadProducts() async {
    _products = await _inventoryService.fetchProducts();
    final now = DateTime.now();
    _criticalCount =
        _products.where((product) {
          final daysToExpire = product.expiryDate.difference(now).inDays;
          return daysToExpire >= 0 && daysToExpire <= 5;
        }).length;

    _mediumCount =
        _products.where((product) {
          final daysToExpire = product.expiryDate.difference(now).inDays;
          return daysToExpire >= 6 && daysToExpire <= 10;
        }).length;

    notifyListeners();
  }

  Future<void> addOrUpdateRecipe(dynamic newRecipe) async {
    final index = _recipes.indexWhere((recipe) => recipe.id == newRecipe.id);
    if (index != -1) {
      _recipes[index] = newRecipe;
    } else {
      _recipes.add(newRecipe); 
    }
    notifyListeners();
  }

  Future<void> addOrUpdateProduct(dynamic newProduct) async {
    final index = _products.indexWhere(
      (product) => product.id == newProduct.id,
    );
    if (index != -1) {
      _products[index] = newProduct;
    } else {
      _products.add(newProduct); 
    }
    notifyListeners();
  }
}
