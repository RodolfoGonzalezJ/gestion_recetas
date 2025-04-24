import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/home/screens/widgets/floating_menu_button.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';
import 'package:gestion_recetas/features/inventory/screens/inventory/inventory.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Inicio')), // Placeholder for the Home page
    const InventoryScreen(), // Inventory page
    const Center(child: Text('Favoritos')), // Placeholder for Favorites page
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    final Color backgroundColor = isDark ? CColors.dark : CColors.primaryColor;
    final Color iconColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Alimentos'),
        actions: [
          IconButton(icon: const Icon(Icons.face), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: _pages[_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: backgroundColor,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
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
      floatingActionButton: const FloatingMenuButton(),
    );
  }
}
