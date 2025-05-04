import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/home/screens/widgets/floating_menu_button.dart';
import 'package:gestion_recetas/features/navigation/screens/widgets/appBar.dart';
import 'package:gestion_recetas/utils/constants/categories.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/features/Comment/screens/CommentScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenRealState();
}

class _HomeScreenRealState extends State<HomeScreen> {
  final categories = ProductCategories.all;
  int seleccionado = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(141, 0, 0, 0),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
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
                    _card('Recetas', 24, 140, 93),
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
                        _card('Estado Critico', 1, 106, 93),
                        _card('Estado Medio', 2, 106, 93),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _sectionTitleWithoutSeeMore(
              'Categorias',
              20,
              FontWeight.bold,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            _categories(),
            const SizedBox(height: 12),
            _sectionTitle('Pronto a Expirar', onPressed: () {}),
            _expiringSoon(),
            const SizedBox(height: 16),
            _sectionTitle('Vistas Recientemente', onPressed: () {}),
            _recentViews(),
            const SizedBox(height: 16),
            _adBanner(),
            const SizedBox(height: 16),
            _sectionTitle('Recomendado para ti', onPressed: () {}),
            _recommendedItems(),
            const SizedBox(height: 16),
            _sectionTitle('En tendencias 🔥', onPressed: () {}),
            _trendingItems(),
            const SizedBox(height: 16),
            _sectionTitle('Recetas de la semana', onPressed: () {}),
            _recommendedItems(),
          ],
        ),
      ),
      floatingActionButton: const FloatingMenuButton(),
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
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[300],
      child: Center(
        child: Text(
          'Anuncioooooooooooooo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _recommendedItems() {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Espagueti Aglio',
        'time': '60 min',
        'image': 'assets/images/EspaguetiAglio.png',
        'rating': '4.9',
        'nivel': '2',
      },
      {
        'title': 'Mote de queso',
        'time': '120 min',
        'image': 'assets/images/moteDeQueso.png',
        'rating': '4.9',
        'nivel': '2',
      },
      {
        'title': 'Salchipapa Casera',
        'time': '50 min',
        'image': 'assets/images/salchipapaCasera.png',
        'rating': '4.0',
        'nivel': '1',
      },
    ];
    return _horizontalList(items);
  }

  Widget _trendingItems() {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Hamburguesa Melosa',
        'time': '180 min',
        'image': 'assets/images/hamburguesaMelosa.png',
        'rating': '5.0',
        'nivel': '3',
      },
      {
        'title': 'Sopa Ajiaco',
        'time': '120 min',
        'image': 'assets/images/sopaAjiaco.png',
        'rating': '4.0',
        'nivel': '2',
      },
      {
        'title': 'Salchipapa Casera',
        'time': '50 min',
        'image': 'assets/images/salchipapaCasera.png',
        'rating': '4.0',
        'nivel': '3',
      },
    ];
    return _horizontalList(items);
  }

  Widget _expiringSoon() {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Brócoli',
        'image': 'assets/images/brocoli.png',
        'cantidad': '9',
        'expira': 'Expira en 1 mes',
      },
      {
        'title': 'Tomate',
        'image': 'assets/images/tomate.png',
        'cantidad': '5',
        'expira': 'Expira en 2 mes',
      },
      {
        'title': 'Leche Condensada',
        'image': 'assets/images/lecheCondensada.png',
        'cantidad': '3',
        'expira': 'Expira en 1 mes',
      },
    ];
    return _horizontalListProducts(items);
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
          return Card(
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
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item['expira']!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item['image']!,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Cantidad: ${item['cantidad']}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _horizontalList(List<Map<String, dynamic>> items) {
    return SizedBox(
      height: 230,
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
                  builder: (context) => CommentScreen(recipeId: item['id']),
                ),
              );
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.asset(
                      item['image']!,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    child: Column(
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
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
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
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: List.generate(
                            3,
                            (i) => Icon(
                              Icons.local_dining,
                              color:
                                  i < int.parse(item['nivel']!)
                                      ? Colors.orangeAccent
                                      : Colors.grey.shade300,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
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
        padding: const EdgeInsets.all(8),
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

  Widget _categories() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final esSeleccionado = index == seleccionado;
          return GestureDetector(
            onTap: () {
              setState(() {
                seleccionado = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    esSeleccionado
                        ? CColors.primaryColor
                        : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color:
                      esSeleccionado
                          ? Colors.white
                          : CColors.secondaryTextColor,
                  fontWeight:
                      esSeleccionado ? FontWeight.bold : FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
