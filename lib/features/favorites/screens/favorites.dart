import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Map<String, dynamic>> favoriteItems = [
    {
      'title': 'Tabulé de huevos con brócoli',
      'description': 'Lorem ipsum dolor sit amet...',
      'image': 'assets/images/1.png',
      'isFavorite': true,
    },
    {
      'title': 'Sartenada de huevos con tomate',
      'description': 'Lorem ipsum dolor sit amet...',
      'image': 'assets/images/2.png',
      'isFavorite': true,
    },
    {
      'title': 'Pollo Cajún',
      'description': 'Lorem ipsum dolor sit amet...',
      'image': 'assets/images/3.png',
      'isFavorite': true,
    },
    {
      'title': 'Sandwich de Atún',
      'description': 'Lorem ipsum dolor sit amet...',
      'image': 'assets/images/4.png',
      'isFavorite': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Recetas')),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.asset(
                item['image']!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(item['title']!),
              subtitle: Text(item['description']!),
              trailing: IconButton(
                icon: Icon(
                  item['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                  color: item['isFavorite'] ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    item['isFavorite'] = !item['isFavorite'];
                  });
                },
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              ),
            ),
          );
        },
      ),
    );
  }
}
