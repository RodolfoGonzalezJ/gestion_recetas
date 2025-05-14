import 'package:flutter/material.dart';

class CollectionScreen extends StatelessWidget {
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
        {'image': 'assets/images/salchipapaCasera.png', 'label': '30+ Recetas'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
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
                      'See all',
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
                                    '32+ Recipes',
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
          );
        },
      ),
    );
  }
}
