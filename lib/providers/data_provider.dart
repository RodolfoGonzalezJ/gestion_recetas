import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/auth/models/models.dart';
import 'package:gestion_recetas/features/inventory/services/inventory_service.dart';
import 'package:gestion_recetas/features/recipes/services/recipe_service.dart';
import 'package:gestion_recetas/data/services/auth_service.dart';

class DataProvider with ChangeNotifier {
  final InventoryService _inventoryService = InventoryService();
  final RecipeService _recipeService = RecipeService();
  final AuthService _authService = AuthService();

  List<dynamic> _recipes = [];
  List<dynamic> _products = [];
  List<UserModel> _users = [];
  int _totalRecipes = 0;
  int _criticalCount = 0;
  int _mediumCount = 0;

  UserModel? _currentUser;

  List<dynamic> get recipes => _recipes;
  List<dynamic> get products => _products;
  List<UserModel> get users => _users;
  int get totalRecipes => _totalRecipes;
  int get criticalCount => _criticalCount;
  int get mediumCount => _mediumCount;
  UserModel? get currentUser => _currentUser;

  // Devuelve solo las recetas creadas por el usuario autenticado
  List<dynamic> get myRecipes =>
      _currentUser == null
          ? []
          : _recipes.where((r) => r.createdBy == _currentUser!.correo).toList();

  // Devuelve solo los productos creados por el usuario autenticado
  List<dynamic> get myProducts =>
      _currentUser == null
          ? []
          : _products
              .where((p) => p.createdBy == _currentUser!.correo)
              .toList();

  // NUEVO: Lista de usuarios seguidos (por correo)
  List<String> _followedUsers = [];
  List<String> get followedUsers => _followedUsers;

  // Cargar usuarios seguidos desde la base de datos o API (ajusta según tu modelo)
  Future<void> loadFollowedUsers(String myEmail) async {
    // Aquí deberías consultar tu base de datos para obtener la lista de correos seguidos por el usuario actual
    // Por ejemplo, si tienes una colección 'follows' con { follower: myEmail, following: otroCorreo }
    // Simulación: _followedUsers = ['correo1@ejemplo.com', 'correo2@ejemplo.com'];
    // TODO: Reemplaza esto por tu consulta real
    _followedUsers = []; // Limpia antes de cargar
    // ...carga real aquí...
    notifyListeners();
  }

  // Seguir a un usuario (agrega al cache y notifica)
  void followUser(String correo) {
    if (!_followedUsers.contains(correo)) {
      _followedUsers.add(correo);
      notifyListeners();
    }
  }

  // Dejar de seguir a un usuario (elimina del cache y notifica)
  void unfollowUser(String correo) {
    _followedUsers.remove(correo);
    notifyListeners();
  }

  bool get isRecipesLoaded => _recipes.isNotEmpty;
  bool get isProductsLoaded => _products.isNotEmpty;
  bool get isUsersLoaded => _users.isNotEmpty;

  Future<void> loadRecipes({bool force = false}) async {
    if (_recipes.isEmpty || force) {
      _recipes = await _recipeService.fetchRecipes();
      _totalRecipes = _recipes.length;
      notifyListeners();
    }
  }

  Future<void> loadProducts({bool force = false}) async {
    if (_products.isEmpty || force) {
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
  }

  Future<void> loadUsers({bool force = false}) async {
    if (_users.isEmpty || force) {
      try {
        final usersData = await _authService.fetchAllUsers();
        _users = usersData.map((data) => UserModel.fromJson(data)).toList();
        notifyListeners();
      } catch (e) {
        print('Error loading users: $e');
      }
    }
  }

  void setCurrentUser(UserModel? user) {
    _currentUser = user;
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

  /// Método para cargar todo el cache inicial (opcional)
  Future<void> loadAll({bool force = false}) async {
    await Future.wait([
      loadRecipes(force: force),
      loadProducts(force: force),
      loadUsers(force: force),
    ]);
    // if (_currentUser?.correo != null) await loadFollowedUsers(_currentUser!.correo!);
  }
}
