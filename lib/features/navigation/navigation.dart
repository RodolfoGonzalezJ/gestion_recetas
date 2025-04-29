import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/favorites/screens/favorites.dart';
import 'package:gestion_recetas/features/home/screens/home.dart';
import 'package:gestion_recetas/features/inventory/screens/inventory/inventory.dart';
//import 'package:gestion_recetas/features/navigation/screens/widgets/appBar.dart';
// import 'package:gestion_recetas/features/navigation/screens/widgets/iconButtonBox.dart';
//import 'package:gestion_recetas/features/home/screens/widgets/floating_menu_button.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
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
    InventoryScreen(), // const InventoryScreen(), // Inventory page
    FavoritesScreen(),
    const Center(
      child: Text('Configuración'),
    ), // Placeholder for Favorites page
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    final Color backgroundColor = isDark ? CColors.dark : CColors.primaryColor;
    final Color resaltar = isDark ? CColors.dark : CColors.resaltar;
    final Color iconColor = Colors.white;

    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: backgroundColor,
        itemShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),

        // indicatorColor: resaltar,
        // indicatorShape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(4),
        // ),
        currentIndex: _currentPageIndex,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        // labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
        //   Set<WidgetState> states,
        // ) {
        //   return TextStyle(color: Colors.white, fontSize: 12);
        // }),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home_outlined, color: iconColor, size: 32),
            title: Text("Inicio"),
            selectedColor: iconColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.inventory_2_outlined, color: iconColor, size: 28),
            title: Text('Inventario'),
            selectedColor: iconColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.bookmark_border, color: iconColor, size: 32),
            title: Text('Colecciones'),
            selectedColor: iconColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.settings_outlined, color: iconColor, size: 32),
            title: Text('Configuración'),
            selectedColor: iconColor,
          ),
        ],
      ),
    );
  }
}
