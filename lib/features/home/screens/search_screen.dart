import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gestion_recetas/providers/data_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  String searchQuery = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    final filteredRecipes =
        dataProvider.recipes.where((recipe) {
          return recipe.name.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

    final filteredProducts =
        dataProvider.products.where((product) {
          return product.name.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

    final filteredUsers =
        dataProvider.users.where((user) {
          return user.nombre?.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ??
              false;
        }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Buscar recetas, productos o usuarios...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.green,
          tabs: const [
            Tab(text: 'Recetas'),
            Tab(text: 'Productos'),
            Tab(text: 'Usuarios'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(filteredRecipes, 'Recetas'),
          _buildList(filteredProducts, 'Productos'),
          _buildList(filteredUsers, 'Usuarios'),
        ],
      ),
    );
  }

  Widget _buildList(List<dynamic> items, String type) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No se encontraron resultados.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              type == 'Usuarios'
                  ? (item.avatarUrl ?? 'assets/images/default_user.png')
                  : type == 'Productos'
                  ? (item.photoUrl ?? 'assets/images/default.png')
                  : (item.imageUrl ?? 'assets/images/default.png'),
            ),
          ),
          title: Text(
            type == 'Usuarios'
                ? '${item.nombre ?? ''} ${item.apellido ?? ''}'
                : item.name,
          ),
          subtitle:
              type == 'Usuarios'
                  ? Text(item.correo ?? 'Sin correo')
                  : type == 'Productos'
                  ? Text('Cantidad: ${item.quantity}')
                  : type == 'Recetas'
                  ? Text('Rating: ${item.averageRating.toStringAsFixed(1)}')
                  : null,
          onTap: () {
            if (type == 'Usuarios') {
              // Navigate to user profile or perform an action
              print('Usuario seleccionado: ${item.nombre}');
            }
            // Add navigation for other types if needed
          },
        );
      },
    );
  }
}
