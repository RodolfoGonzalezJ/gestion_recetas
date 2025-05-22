import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart';
import 'package:gestion_recetas/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:gestion_recetas/features/home/screens/detail.dart';
import 'package:gestion_recetas/features/home/screens/widgets/floating_menu_button.dart';
import 'package:gestion_recetas/features/navigation/screens/widgets/appBar.dart';
import 'package:gestion_recetas/utils/constants/categories.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'dart:io';
import 'package:gestion_recetas/features/home/screens/search_screen.dart';
import 'package:gestion_recetas/features/home/screens/widgets/recommended_recipes.dart';
import 'package:gestion_recetas/features/auth/models/models.dart';
import 'package:gestion_recetas/features/auth/controllers/controllers.dart';
import 'package:gestion_recetas/features/home/screens/product_detail_expiring.dart';
import 'package:gestion_recetas/features/home/screens/widgets/recommended_recipes.dart';
import 'package:gestion_recetas/features/home/screens/see_more_recipes_screen.dart';
import 'package:gestion_recetas/features/home/screens/widgets/hero_ad_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenRealState();
}

class _HomeScreenRealState extends State<HomeScreen> {
  String searchQuery = ''; // Define searchQuery
  String selectedRecipeCategory = 'Todos'; // Define selectedRecipeCategory

  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.loadRecipes();
    dataProvider.loadProducts();
    dataProvider.loadUsers(); // Load users

    // Inicializa el usuario autenticado solo una vez después del primer frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dataProvider = Provider.of<DataProvider>(context, listen: false);
      if (dataProvider.currentUser == null) {
        final user = AuthController().user;
        if (user != null) {
          dataProvider.setCurrentUser(user);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    final UserModel? currentUser = dataProvider.currentUser;

    // Asegura que los datos existen o usa valores por defecto
    final recipes = dataProvider.recipes ?? [];
    final products = dataProvider.products ?? [];

    // Filtra recetas y productos creados por el usuario actual
    final myRecipes =
        currentUser == null
            ? []
            : recipes.where((r) => r.createdBy == currentUser.correo).toList();
    final myProducts =
        currentUser == null
            ? []
            : products.where((p) => p.createdBy == currentUser.correo).toList();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(141, 0, 0, 0),
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9.0),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Text(
                      'Buscar recetas, productos o usuarios...',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Column(
                  children: [
                    _sectionTitleWithoutSeeMore(
                      'Recetas Totales',
                      16,
                      FontWeight.w600,
                      onPressed: () {},
                    ),
                    _card(
                      'Recetas',
                      dataProvider.totalRecipes,
                      (MediaQuery.of(context).size.width * 0.35),
                      93,
                    ),
                  ],
                ),
                Column(
                  children: [
                    _sectionTitleWithoutSeeMore(
                      'Lote de Inventario',
                      16,
                      FontWeight.w600,
                      onPressed: () {},
                    ),
                    Row(
                      children: [
                        _card(
                          'Estado Critico',
                          dataProvider.criticalCount,
                          (MediaQuery.of(context).size.width * 0.25),
                          93,
                        ),
                        _card(
                          'Estado Medio',
                          dataProvider.mediumCount,
                          (MediaQuery.of(context).size.width * 0.25),
                          93,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _sectionTitleWithoutSeeMore(
              'Pronto a Expirar',
              20,
              FontWeight.bold,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            _expiringSoon(dataProvider.products),
            const SizedBox(height: 16),
            _sectionTitleWithoutSeeMore(
              'Categorias',
              20,
              FontWeight.bold,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            _categories(),
            const SizedBox(height: 16),
            _sectionTitle(
              'Todas las recetas 🔥',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => SeeMoreRecipesScreen(
                          title: 'Todas las recetas',
                          recipes:
                              (dataProvider.recipes ?? [])
                                  .whereType<Recipe>()
                                  .toList(),
                        ),
                  ),
                );
              },
            ),
            _trendingItems(recipes),
            const SizedBox(height: 16),
            _adBanner(),
            RecommendedRecipesWidget(
              currentUserEmail:
                  currentUser?.correo ?? AuthController().user.correo ?? '',
            ),
            const SizedBox(height: 16),
            _sectionTitle(
              'En tendencias 🔥',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => SeeMoreRecipesScreen(
                          title: 'En tendencias',
                          recipes: _getTrendingRecipes(dataProvider.recipes),
                        ),
                  ),
                );
              },
            ),
            _trendingItemsSortedByRating(dataProvider.recipes),
            const SizedBox(height: 16),
            _sectionTitle(
              'Recetas de la semana',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => SeeMoreRecipesScreen(
                          title: 'Recetas de la semana',
                          recipes: _getWeeklyRecipes(dataProvider.recipes),
                        ),
                  ),
                );
              },
            ),
            _weeklyRecipesLast8Days(dataProvider.recipes),
          ],
        ),
      ),
      floatingActionButton: FloatingMenuButton(
        onRefresh: () {
          dataProvider.loadRecipes();
          dataProvider.loadProducts();
        },
      ),
    );
  }

  Widget _categories() {
    final categories = ['Todos', ...RecipeCategories.all];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = categories[index] == selectedRecipeCategory;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedRecipeCategory = categories[index];
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? CColors.primaryColor : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : CColors.secondaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _filteredRecipes(List<dynamic> recipes) {
    final filteredItems =
        recipes
            .where(
              (recipe) =>
                  (selectedRecipeCategory == 'Todos' ||
                      recipe.category == selectedRecipeCategory) &&
                  recipe.name.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

    return _horizontalList(
      filteredItems.map((recipe) {
        return {
          'id': recipe.id,
          'title': recipe.name,
          'time': '${recipe.preparationTime.inMinutes} min',
          'image': recipe.imageUrl ?? 'assets/images/default.png',
          'rating': recipe.averageRating.toStringAsFixed(1),
          'nivel': recipe.difficulty,
        };
      }).toList(),
    );
  }

  Widget _recentViews() {
    final List<Map<String, dynamic>> items = [
      {
        'id': 'recipe1',
        'title': 'Sandwichito Sabrosito',
        'time': '20 min',
        'image': 'assets/images/sandwichitoSabrosito.png',
        'rating': '4.9',
        'nivel': '1',
      },
      {
        'id': 'recipe2',
        'title': 'Buñuelo Asado',
        'time': '40 min',
        'image': 'assets/images/buñueloAsado.png',
        'rating': '4.9',
        'nivel': '2',
      },
      {
        'id': 'recipe3',
        'title': 'Pasta Alemán-Italia',
        'time': '120 min',
        'image': 'assets/images/pastaAlemanItalia.png',
        'rating': '4.0',
        'nivel': '1',
      },
    ];
    return _horizontalList(items);
  }

  Widget _adBanner() {
    return HeroAdBanner();
  }

  Widget _recommendedItems(List<dynamic> recipes) {
    final filteredItems =
        recipes.where((recipe) {
          return selectedRecipeCategory == 'Todos' ||
              recipe.category == selectedRecipeCategory;
        }).toList();

    return _horizontalList(
      filteredItems.map((recipe) {
        return {
          'id': recipe.id,
          'title': recipe.name,
          'time': '${recipe.preparationTime.inMinutes} min',
          'image': recipe.imageUrl ?? 'assets/images/default.png',
          'rating': recipe.averageRating.toStringAsFixed(1),
          'nivel': recipe.difficulty,
        };
      }).toList(),
    );
  }

  Widget _trendingItems(List<dynamic> recipes) {
    // Use cached recipes for trending items
    return _recommendedItems(recipes);
  }

  Widget _weeklyRecipes(List<dynamic> recipes) {
    // Use cached recipes for weekly items
    return _recommendedItems(recipes);
  }

  Widget _expiringSoon(List<dynamic> products) {
    final filteredItems =
        products
            .where(
              (product) => product.name.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList();

    filteredItems.sort((a, b) => a.expiryDate.compareTo(b.expiryDate));

    return _horizontalListProducts(
      filteredItems.map((product) {
        final daysToExpire =
            product.expiryDate.difference(DateTime.now()).inDays;
        final status =
            daysToExpire < 0
                ? 'Vencido'
                : daysToExpire == 0
                ? 'Hoy'
                : 'Expira en $daysToExpire días';
        final quantityStatus =
            product.quantity == 0 ? 'Agotado' : 'Cantidad: ${product.quantity}';

        return {
          'id': product.id, // <-- Agrega el id para navegación
          'title': product.name,
          'image': product.photoUrl ?? 'assets/images/default.png',
          'cantidad': quantityStatus,
          'expira': status,
          'product': product, // <-- Pasa el objeto producto completo
        };
      }).toList(),
    );
  }

  Widget _horizontalListProducts(List<Map<String, dynamic>> items) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final item = items[index];
          final statusColor = _getExpirationColor(item['expira']!);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          ProductDetailExpiringScreen(product: item['product']),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(141, 0, 0, 0),
                      blurRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                width: 140,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item['expira']!,
                        style: TextStyle(
                          fontSize: 11,
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _loadImage(item['image']),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['title']!.length > 16
                          ? '${item['title']!.substring(0, 14)}...'
                          : item['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['cantidad']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getExpirationColor(String status) {
    if (status.contains('Vencido')) {
      return Colors.red;
    } else if (status.contains('Hoy')) {
      return Colors.orange;
    } else if (status.contains('Expira en')) {
      return Colors.green;
    }
    return Colors.grey;
  }

  Widget _horizontalList(List<Map<String, dynamic>> items) {
    return Container(
      height: 195,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RecipeDetailPage(
                        recipeId: item['id'], // Pasar el ID de la receta
                      ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: _loadImage(item['image']),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.green.shade700,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['time']!,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 14,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            item['rating']!,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['nivel']!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getDifficultyColor(item['nivel']!),
                            ),
                          ),
                        ],
                      ),

                      // Row(
                      //   children: [
                      //     const Icon(
                      //       Icons.star,
                      //       color: Colors.orange,
                      //       size: 14,
                      //     ),
                      //     const SizedBox(width: 2),
                      //     Text(
                      //       item['rating']!,
                      //       style: const TextStyle(fontSize: 12),
                      //     ),
                      //   ],
                      // ),

                      // DifficultyIndicatorR(level: item['nivel']),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Fácil':
        return Colors.green;
      case 'Media':
        return Colors.orange;
      case 'Difícil':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _loadImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      // Si no hay imagen, usa la imagen predeterminada
      return Image.asset(
        'assets/images/1.png', // Ruta correcta
        height: 100,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('http')) {
      // Si la imagen es una URL, usa Image.network
      return Image.network(
        imagePath,
        height: 100,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/1.png', // Imagen predeterminada
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      // Si la imagen es una ruta local, usa Image.file
      return Image.file(
        File(imagePath),
        height: 100,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/1.png', // Imagen predeterminada
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          );
        },
      );
    }
  }

  /// Devuelve las recetas ordenadas por averageRating (mayor a menor)
  List<Recipe> _getTrendingRecipes(List<dynamic> recipes) {
    final recipeList = recipes.whereType<Recipe>().toList();
    recipeList.sort((a, b) => b.averageRating.compareTo(a.averageRating));
    return recipeList;
  }

  /// Devuelve las recetas de la semana (últimos 8 días con comentarios)
  List<Recipe> _getWeeklyRecipes(List<dynamic> recipes) {
    final now = DateTime.now();
    final eightDaysAgo = now.subtract(const Duration(days: 8));
    final filtered =
        recipes.whereType<Recipe>().where((recipe) {
          if (recipe.comments == null || recipe.comments.isEmpty) return false;
          return recipe.comments.any(
            (c) =>
                c['createdAt'] != null &&
                    (c['createdAt'] is DateTime
                            ? c['createdAt']
                            : DateTime.tryParse(c['createdAt'].toString()))
                        ?.isAfter(eightDaysAgo) ??
                false,
          );
        }).toList();
    filtered.sort((a, b) => b.averageRating.compareTo(a.averageRating));
    return filtered;
  }

  Widget _sectionTitle(String title, {required VoidCallback onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: CColors.secondaryTextColor,
          ),
        ),
        TextButton(onPressed: onPressed, child: Text('Ver más')),
      ],
    );
  }

  Widget _sectionTitleWithoutSeeMore(
    String title,
    double fontSize,
    FontWeight fontWeight, {
    required VoidCallback onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: CColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _card(String titulo, int cantidad, double width, double height) {
    return Card(
      color: CColors.lightContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: const Color.fromARGB(144, 0, 0, 0),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: CColors.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$cantidad',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: CColors.primaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Muestra las recetas ordenadas por averageRating (mayor a menor) en "En tendencias 🔥"
  Widget _trendingItemsSortedByRating(List<dynamic> recipes) {
    final recipeList = recipes.whereType<Recipe>().toList();
    recipeList.sort((a, b) => b.averageRating.compareTo(a.averageRating));
    return _horizontalList(
      recipeList.map((recipe) {
        return {
          'id': recipe.id,
          'title': recipe.name,
          'time': '${recipe.preparationTime.inMinutes} min',
          'image': recipe.imageUrl ?? 'assets/images/default.png',
          'rating': recipe.averageRating.toStringAsFixed(1),
          'nivel': recipe.difficulty,
        };
      }).toList(),
    );
  }

  /// Recetas de la semana: recetas con comentarios en los últimos 8 días, ordenadas por rating
  Widget _weeklyRecipesLast8Days(List<dynamic> recipes) {
    final now = DateTime.now();
    final eightDaysAgo = now.subtract(const Duration(days: 8));

    // Se asume que cada receta tiene una lista de comentarios con campo createdAt y rating
    final filtered =
        recipes.whereType<Recipe>().where((recipe) {
          // Si no hay comentarios, no se muestra
          if (recipe.comments == null || recipe.comments.isEmpty) return false;
          // Al menos un comentario en los últimos 8 días
          return recipe.comments.any(
            (c) =>
                c['createdAt'] != null &&
                    (c['createdAt'] is DateTime
                            ? c['createdAt']
                            : DateTime.tryParse(c['createdAt'].toString()))
                        ?.isAfter(eightDaysAgo) ??
                false,
          );
        }).toList();

    // Ordena por averageRating descendente
    filtered.sort((a, b) => b.averageRating.compareTo(a.averageRating));

    return _horizontalList(
      filtered.map((recipe) {
        return {
          'id': recipe.id,
          'title': recipe.name,
          'time': '${recipe.preparationTime.inMinutes} min',
          'image': recipe.imageUrl ?? 'assets/images/default.png',
          'rating': recipe.averageRating.toStringAsFixed(1),
          'nivel': recipe.difficulty,
        };
      }).toList(),
    );
  }
}
