import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/home/screens/widgets/floating_menu_button.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    final Color backgroundColor = isDark ? CColors.dark : CColors.primaryColor;
    final Color iconColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Alimentos'),
        actions: [
          IconButton(icon: Icon(Icons.face), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            _sectionTitle('Vistas Recientemente', onPressed: () {}),
            _recentViews(),
            SizedBox(height: 16),
            _adBanner(),
            SizedBox(height: 16),
            _sectionTitle('Recomendado para ti', onPressed: () {}),
            _recommendedItems(),
            SizedBox(height: 16),
            _sectionTitle('En tendencias 🔥', onPressed: () {}),
            _trendingItems(),
            SizedBox(height: 16),
            _sectionTitle('Pronto a Expirar', onPressed: () {}),
            _expiringSoon(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
            Set<WidgetState> states,
          ) {
            return TextStyle(
              color: isDark ? Colors.white : Colors.white,
              fontSize: 16,
            );
          }),
        ),
        child: NavigationBar(
          //selectedIndex: currentPageIndex,
          backgroundColor: backgroundColor,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home, color: iconColor),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.list, color: iconColor),
              label: 'Inventario',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite, color: iconColor),
              label: 'Favoritos',
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingMenuButton(),
    );
  }

  Widget _recentViews() {
    List<String> items = [
      'Sandwichito Sabrosito',
      'Buñuelo Asado',
      'Pasta Alemán-Italia',
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _recommendedItems() {
    List<String> items = [
      'Espagueti Aglio',
      'Mote de queso',
      'Salchipapa Casera',
    ];
    return _horizontalList(items);
  }

  Widget _trendingItems() {
    List<String> items = [
      'Hamburguesa Melosa',
      'Sopa Ajiaco',
      'Salchipapa Casera',
    ];
    return _horizontalList(items);
  }

  Widget _expiringSoon() {
    List<String> items = ['Brócoli', 'Tomate', 'Leche Condensada'];
    return _horizontalList(items);
  }

  Widget _horizontalList(List<String> items) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              width: 130,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Icon(Icons.fastfood, size: 40),
                  Text(items[index]),
                  Text('Tiempo: 20 min', style: TextStyle(fontSize: 12)),
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: onPressed, child: Text('Ver más')),
      ],
    );
  }
}
