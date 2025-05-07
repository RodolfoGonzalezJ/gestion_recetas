// import 'package:flutter/material.dart';

// class RecipeDetailPage extends StatelessWidget {
//   final recipe = {
//     'title': 'Choco Macarons',
//     'author': 'Rachel William',
//     'rating': 4.5,
//     'time': '10 mins',
//     'difficulty': 'Medium',
//     'calories': '512 cal',
//     'description':
//         'Chocolate is the best kind of dessert! These choco macarons are simply heavenly! Delicate little cookies filled with chocolate ganache.',
//     'ingredients': [
//       {'name': 'Granulated sugar', 'amount': '160 g', 'icon': Icons.sugar},
//       {'name': 'Ground almond', 'amount': '160 g', 'icon': Icons.cookie},
//       {'name': 'Dark chocolate', 'amount': '110 g', 'icon': Icons.cake},
//     ],
//     'image': 'assets/macaron.jpg', // tu imagen local
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Imagen superior
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   bottom: Radius.circular(32),
//                 ),
//                 child: Image.asset(
//                   recipe['image']!,
//                   width: double.infinity,
//                   height: 250,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 top: 40,
//                 left: 16,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 40,
//                 right: 16,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: IconButton(
//                     icon: const Icon(Icons.bookmark_border),
//                     onPressed: () {},
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Contenido inferior
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Título y rating
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         recipe['title']!,
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(Icons.star, color: Colors.orange),
//                           Text(recipe['rating'].toString()),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'By ${recipe['author']}',
//                     style: const TextStyle(color: Colors.grey),
//                   ),

//                   const SizedBox(height: 16),

//                   // Stats
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildStat(Icons.schedule, recipe['time']),
//                       _buildStat(Icons.signal_cellular_alt, recipe['difficulty']),
//                       _buildStat(Icons.local_fire_department, recipe['calories']),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Descripción
//                   const Text(
//                     'Description',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     recipe['description']!,
//                     style: const TextStyle(color: Colors.black87),
//                   ),

//                   const SizedBox(height: 20),

//                   // Ingredientes
//                   const Text(
//                     'Ingredients',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(height: 10),
//                   ...recipe['ingredients']!.map<Widget>((ingredient) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4),
//                       child: Row(
//                         children: [
//                           Icon(ingredient['icon'], size: 24),
//                           const SizedBox(width: 8),
//                           Expanded(child: Text(ingredient['name'])),
//                           Text(ingredient['amount']),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ],
//               ),
//             ),
//           ),

//           // Botón inferior
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.play_circle_fill),
//                 label: const Text('Watch Videos'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStat(IconData icon, String value) {
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: Colors.grey[600]),
//         const SizedBox(width: 4),
//         Text(value),
//       ],
//     );
//   }
// }
