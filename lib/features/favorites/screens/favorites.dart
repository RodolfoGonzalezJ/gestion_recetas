import 'package:flutter/material.dart';

class CollectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Tus colecciones',
      'items': [
        {'image': 'assets/images/brocoli.png', 'label': 'Ver más'},
        {'image': 'assets/images/buñueloAsado.png', 'label': '30+ Recetas'},
      ],
    },
    {
      'title': 'Desayunos',
      'items': [
        {'image': 'assets/images/EspaguetiAglio.png', 'label': 'Ver más'},
        {
          'image': 'assets/images/hamburguesaMelosa.png',
          'label': '30+ Recetas',
        },
      ],
    },
    {
      'title': 'Saludables',
      'items': [
        {'image': 'assets/images/lecheCondensada.png', 'label': 'Ver más'},
        {'image': 'assets/images/moteDeQueso.png', 'label': '30+ Recetas'},
      ],
    },
    {
      'title': 'Comidas Rápidas',
      'items': [
        {'image': 'assets/images/pastaAlemanItalia.png', 'label': 'Ver más'},
        {'image': 'assets/images/salchipapaCasera.png', 'label': '30+ Recetas'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colecciones'),
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
                      'Ver más',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2.0,
                  ),
                  itemCount: category['items'].length,
                  itemBuilder: (context, itemIndex) {
                    final item = category['items'][itemIndex];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            item['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              item['label'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
