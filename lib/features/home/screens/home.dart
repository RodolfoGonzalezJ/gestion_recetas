import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Alimentos'),
        actions: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoCard('Recetas', '24'),
                _infoCard('Estado Crítico', '1'),
                _infoCard('Estado Medio', '2'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Categorías',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _categories(),
            SizedBox(height: 16),
            _sectionTitle('Pronto a Expirar', onPressed: () {}),
            _expiringItems(),
            SizedBox(height: 16),
            _sectionTitle('Vistas Recientemente', onPressed: () {}),
            _recentViews(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Categorías'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(value, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categories() {
    List<String> categories = ['Todo', 'Sopa', 'Fideos', 'Fritos', 'Ron'];
    return Wrap(
      spacing: 8,
      children:
          categories.map((category) {
            return Chip(label: Text(category));
          }).toList(),
    );
  }

  Widget _expiringItems() {
    List<String> items = ['Brócoli', 'Tomate', 'Leche condensada'];
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              width: 100,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Icon(Icons.food_bank, size: 40),
                  Text(items[index]),
                  Text('Cantidad: 5', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _recentViews() {
    List<String> recent = ['Sandwich', 'Buñuelo', 'Pasta'];
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recent.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              width: 120,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Icon(Icons.fastfood, size: 40),
                  Text(recent[index]),
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
