import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/home/screens/search_screen.dart';
import 'package:gestion_recetas/features/navigation/screens/widgets/appBar.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';

class CollectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: _CollectionsSection()),
        ],
      ),
    );
  }

  Widget _CollectionsSection() {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Tus colecciones',
        'items': [
          {'image': 'assets/images/brocoli.png', 'label': ''},
          {'image': 'assets/images/sandwichitoSabrosito.png', 'label': ''},
          {'image': 'assets/images/buñueloAsado.png', 'label': '30+ Recetas'},
        ],
      },
      {
        'title': 'Desayunos',
        'items': [
          {'image': 'assets/images/EspaguetiAglio.png', 'label': ''},
          {'image': 'assets/images/sopaAjiaco.png', 'label': ''},
          {
            'image': 'assets/images/hamburguesaMelosa.png',
            'label': '30+ Recetas',
          },
        ],
      },
      {
        'title': 'Saludables',
        'items': [
          {'image': 'assets/images/lecheCondensada.png', 'label': ''},
          {'image': 'assets/images/tomate.png', 'label': ''},
          {'image': 'assets/images/moteDeQueso.png', 'label': '30+ Recetas'},
        ],
      },
      {
        'title': 'Comidas Rápidas',
        'items': [
          {'image': 'assets/images/pastaAlemanItalia.png', 'label': ''},
          {'image': 'assets/images/tomate.png', 'label': ''},
          {
            'image': 'assets/images/salchipapaCasera.png',
            'label': '30+ Recetas',
          },
        ],
      },
    ];
    return _buildCategorySection(categories);
  }

  Widget _buildCategorySection(List<Map<String, dynamic>> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category['title'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Ver más',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          category['items'][0]['image'],
                          fit: BoxFit.cover,
                          height: 140,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              category['items'][1]['image'],
                              fit: BoxFit.cover,
                              height: 66,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  category['items'][2]['image'],
                                  fit: BoxFit.cover,
                                  height: 66,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  color: Colors.black54,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 2,
                                  ),
                                  child: const Text(
                                    '32+ Recetas',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
}
