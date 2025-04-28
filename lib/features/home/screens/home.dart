import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/home/screens/widgets/floating_menu_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenRealState();
}

class _HomeScreenRealState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _sectionTitle('Pronto a Expirar', onPressed: () {}),
            _expiringSoon(),
            const SizedBox(height: 16),
            _adBanner(),
            const SizedBox(height: 16),
            _sectionTitle('Vistas Recientemente', onPressed: () {}),
            _recentViews(),
            const SizedBox(height: 16),
            _sectionTitle('Recomendado para ti', onPressed: () {}),
            _recommendedItems(),
            const SizedBox(height: 16),
            _sectionTitle('En tendencias 🔥', onPressed: () {}),
            _trendingItems(),
          ],
        ),
      ),
      floatingActionButton: const FloatingMenuButton(),
    );
  }

  Widget _recentViews() {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Sandwichito Sabrosito',
        'time': '20 min',
        'image': 'assets/images/sandwichitoSabrosito.png',
      },
      {
        'title': 'Buñuelo Asado',
        'time': '20 min',
        'image': 'assets/images/buñueloAsado.png',
      },
      {
        'title': 'Pasta Alemán-Italia',
        'time': '20 min',
        'image': 'assets/images/pastaAlemanItalia.png',
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _recommendedItems() {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Espagueti Aglio',
        'time': '20 min',
        'image': 'assets/images/EspaguetiAglio.png',
      },
      {
        'title': 'Mote de queso',
        'time': '20 min',
        'image': 'assets/images/moteDeQueso.png',
      },
      {
        'title': 'Salchipapa Casera',
        'time': '20 min',
        'image': 'assets/images/salchipapaCasera.png',
      },
    ];
    return _horizontalList(items);
  }

  Widget _trendingItems() {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Hamburguesa Melosa',
        'time': '20 min',
        'image': 'assets/images/hamburguesaMelosa.png',
      },
      {
        'title': 'Sopa Ajiaco',
        'time': '20 min',
        'image': 'assets/images/sopaAjiaco.png',
      },
      {
        'title': 'Salchipapa Casera',
        'time': '20 min',
        'image': 'assets/images/salchipapaCasera.png',
      },
    ];
    return _horizontalList(items);
  }

  Widget _expiringSoon() {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Brócoli',
        'time': '30 min',
        'image': 'assets/images/brocoli.png',
      },
      {
        'title': 'Tomate',
        'time': '20 min',
        'image': 'assets/images/tomate.png',
      },
      {
        'title': 'Leche Condensada',
        'time': '20 min',
        'image': 'assets/images/lecheCondensada.png',
      },
    ];
    return _horizontalList(items);
  }

  Widget _horizontalList(List<Map<String, dynamic>> items) {
    return SizedBox(
      height: 210,
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
                  Image.asset(items[index]['image']!),
                  Text(items[index]['title']!),
                  Text(
                    'Tiempo: ${items[index]['time']}',
                    style: TextStyle(fontSize: 12),
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: onPressed, child: Text('Ver más')),
      ],
    );
  }
}
