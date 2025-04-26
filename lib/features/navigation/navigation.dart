import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/favorites/screens/favorites.dart';
import 'package:gestion_recetas/features/home/screens/home.dart';
import 'package:gestion_recetas/features/navigation/screens/widgets/iconButtonBox.dart';
//import 'package:gestion_recetas/features/home/screens/widgets/floating_menu_button.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';
// import 'package:gestion_recetas/features/inventory/screens/inventory/inventory.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NavigationScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(), // Placeholder for the Home page
    const Center(
      child: Text('Inventario'),
    ), // const InventoryScreen(), // Inventory page
    FavoritesScreen(),
    const Center(child: Text('Perfil')), // Placeholder for Favorites page
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    final Color backgroundColor = isDark ? CColors.dark : CColors.primaryColor;
    final Color resaltar = isDark ? CColors.dark : CColors.resaltar;
    final Color iconColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: iconButtonBox(
            imagePath: 'assets/logos/logo.png',
            onTap: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/logos/Ellipse 2.png'),
                ),
                SizedBox(width: 16),
                iconButtonBox(
                  imagePath: 'assets/logos/Frame.png',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      body: _pages[_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: backgroundColor,
        indicatorColor: resaltar,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
          Set<WidgetState> states,
        ) {
          return TextStyle(color: Colors.white, fontSize: 16);
        }),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: iconColor, size: 32),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined, color: iconColor, size: 28),
            label: 'Inventario',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border, color: iconColor, size: 32),
            label: 'Colecciones',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined, color: iconColor, size: 32),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
