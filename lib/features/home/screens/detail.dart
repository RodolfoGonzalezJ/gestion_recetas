import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gestion_recetas/features/Comment/models/models.dart';
import 'package:gestion_recetas/features/recipes/services/recipe_service.dart';

extension DateTimeExtensions on DateTime {
  String getRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inMinutes < 1) {
      return 'Justo ahora';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} d';
    } else {
      return '${difference.inDays ~/ 7} sem';
    }
  }
}

class RecipeDetailPage extends StatefulWidget {
  final String recipeId;

  const RecipeDetailPage({Key? key, required this.recipeId}) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final RecipeService _recipeService = RecipeService();
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0.0;
  late Future<Map<String, dynamic>> _recipeData;

  @override
  void initState() {
    super.initState();
    _recipeData = _fetchRecipeData();
  }

  Future<Map<String, dynamic>> _fetchRecipeData() async {
    final recipe = await _recipeService.fetchRecipeById(widget.recipeId);
    final comments = await _recipeService.fetchComments(widget.recipeId);
    return {'recipe': recipe, 'comments': comments};
  }

  Future<void> _addComment(String content, double rating) async {
    final newComment = Comment(
      id: '',
      recipeId: widget.recipeId,
      userId: 'user123', // Reemplazar con el ID real del usuario
      userName: 'Usuario Anónimo', // Reemplazar con el nombre real del usuario
      content: content,
      rating: rating,
      createdAt: DateTime.now(),
    );

    await _recipeService.addCommentToRecipe(widget.recipeId, newComment);

    setState(() {
      _recipeData = _fetchRecipeData(); // Recargar los datos
      _commentController.clear();
      _rating = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _recipeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar la receta.'));
          }

          final recipe = snapshot.data!['recipe'];
          final comments = snapshot.data!['comments'] as List<Comment>;

          return Column(
            children: [
              // Imagen superior
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                    child: Image.network(
                      recipe.imageUrl ?? 'assets/images/1.png',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/1.png', // Imagen predeterminada
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),

              // Contenido inferior
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título y rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            recipe.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.orange),
                              Text(recipe.averageRating.toStringAsFixed(1)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStat(
                            Icons.schedule,
                            '${recipe.preparationTime.inMinutes} mins',
                          ),
                          _buildStat(
                            Icons.signal_cellular_alt,
                            recipe.difficulty,
                          ),
                          _buildStat(
                            Icons.local_fire_department,
                            '${recipe.calories} cal',
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Descripción
                      const Text(
                        'Descripción',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        recipe.description,
                        style: const TextStyle(color: Colors.black87),
                      ),

                      const SizedBox(height: 20),

                      // Ingredientes
                      const Text(
                        'Ingredientes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...recipe.ingredients.map<Widget>((ingredient) {
                        // Acceder correctamente a las propiedades del objeto `Product`
                        final ingredientName =
                            ingredient.name; // Usar la propiedad `name`
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.circle, size: 8),
                              const SizedBox(width: 8),
                              Expanded(child: Text(ingredientName)),
                            ],
                          ),
                        );
                      }).toList(),

                      const SizedBox(height: 20),

                      // Comentarios
                      // Center(
                      //   child: ElevatedButton(
                      //     onPressed:
                      //         () => _mostrarComentarios(context, comments),
                      //     child: const Text('Ver todos'),
                      //   ),
                      // ),
                      // const SizedBox(height: 16),

                      // Comentarios
                      const Text(
                        'Comentarios',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ...comments.map((comment) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Text(comment.userName[0]),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            title: Row(
                              children: [
                                Text(
                                  comment.userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(comment.createdAt.getRelativeTime()),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comment.content),
                                const SizedBox(height: 4),

                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    Text(comment.rating.toStringAsFixed(1)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 20),

                      // Positioned(
                      //   left: 0,
                      //   right: 0,
                      //   bottom: 0,
                      //   child: Container(
                      //     padding: const EdgeInsets.all(16),
                      //     decoration: const BoxDecoration(
                      //       color: Colors.white,
                      //       border: Border(
                      //         top: BorderSide(color: Colors.grey, width: 0.5),
                      //       ),
                      //     ),
                      //     child: Column(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         const Text(
                      //           'Añadir comentario',
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 16,
                      //           ),
                      //         ),
                      //         const SizedBox(height: 10),
                      //         TextField(
                      //           controller: _commentController,
                      //           decoration: const InputDecoration(
                      //             labelText: 'Escribe tu comentario aquí',
                      //             border: OutlineInputBorder(),
                      //           ),
                      //         ),
                      //         const SizedBox(height: 10),
                      //         Row(
                      //           children: [
                      //             const Text('Rating:'),
                      //             Expanded(
                      //               child: Slider(
                      //                 value: _rating,
                      //                 onChanged: (value) {
                      //                   setState(() {
                      //                     _rating = value;
                      //                   });
                      //                 },
                      //                 min: 0,
                      //                 max: 5,
                      //                 divisions: 5,
                      //                 label: _rating.toString(),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         ElevatedButton(
                      //           onPressed: () {
                      //             if (_commentController.text.isNotEmpty) {
                      //               _addComment(
                      //                 _commentController.text,
                      //                 _rating,
                      //               );
                      //             }
                      //           },
                      //           style: ElevatedButton.styleFrom(
                      //             backgroundColor: Colors.green,
                      //           ),
                      //           child: const Text('Enviar'),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      // Container(
                      //   padding: const EdgeInsets.all(16),
                      //   decoration: const BoxDecoration(
                      //     color: Colors.white,
                      //     border: Border(
                      //       top: BorderSide(color: Colors.grey, width: 0.5),
                      //     ),
                      //   ),
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       const Text(
                      //         'Añadir comentario',
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 16,
                      //         ),
                      //       ),
                      //       const SizedBox(height: 10),
                      //       TextField(
                      //         controller: _commentController,
                      //         decoration: const InputDecoration(
                      //           labelText: 'Escribe tu comentario aquí',
                      //           border: OutlineInputBorder(),
                      //         ),
                      //       ),
                      //       const SizedBox(height: 10),
                      //       Row(
                      //         children: [
                      //           const Text('Rating:'),
                      //           Expanded(
                      //             child: Slider(
                      //               value: _rating,
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   _rating = value;
                      //                 });
                      //               },
                      //               min: 0,
                      //               max: 5,
                      //               divisions: 5,
                      //               label: _rating.toString(),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       ElevatedButton(
                      //         onPressed: () {
                      //           if (_commentController.text.isNotEmpty) {
                      //             _addComment(_commentController.text, _rating);
                      //           }
                      //         },
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.green,
                      //         ),
                      //         child: const Text('Enviar'),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const Text(
                      //   'Añadir comentario',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16,
                      //   ),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(141, 0, 0, 0),
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: 'Escribe tu comentario aquí',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade400,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                if (_commentController.text.isNotEmpty) {
                                  _addComment(_commentController.text, _rating);
                                }
                              },
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Calificación:'),
                          // Slider(
                          //   value: _rating,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _rating = value;
                          //     });
                          //   },
                          //   min: 0,
                          //   max: 5,
                          //   divisions: 5,
                          //   label: _rating.toString(),
                          // ),
                          RatingBar.builder(
                            initialRating: _rating,
                            minRating: 0,
                            maxRating: 5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            itemBuilder:
                                (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (value) {
                              setState(() {
                                _rating = value;
                              });
                            },
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     if (_commentController.text.isNotEmpty) {
                          //       _addComment(_commentController.text, _rating);
                          //     }
                          //   },
                          //   icon: Icon(Icons.send, color: Colors.green),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStat(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(value),
      ],
    );
  }

  // void _mostrarComentarios(BuildContext context, List<Comment> comments) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return FractionallySizedBox(

  //         heightFactor: 0.85,

  //         builder: (context, scrollController) {
  //           return Container(
  //             padding: const EdgeInsets.all(16),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text(
  //                   'Comentarios',
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 SizedBox(
  //                   height: MediaQuery.of(context).size.height * 0.6,
  //                   child: Column(
  //                     children: [
  //                       Expanded(
  //                         child: ListView.builder(
  //                           controller: scrollController,
  //                           itemCount: comments.length,
  //                           itemBuilder: (context, index) {
  //                             final comment = comments[index];
  //                             return Container(
  //                               margin: const EdgeInsets.symmetric(vertical: 8),
  //                               child: ListTile(
  //                                 leading: CircleAvatar(
  //                                   backgroundColor: Colors.grey[300],
  //                                   child: Text(comment.userName[0]),
  //                                 ),
  //                                 contentPadding: const EdgeInsets.all(10),
  //                                 title: Row(
  //                                   children: [
  //                                     Text(
  //                                       comment.userName,
  //                                       style: const TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                     const SizedBox(width: 8),
  //                                     Text(comment.createdAt.getRelativeTime()),
  //                                   ],
  //                                 ),
  //                                 subtitle: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Text(comment.content),
  //                                     const SizedBox(height: 4),
  //                                     Row(
  //                                       children: [
  //                                         const Icon(
  //                                           Icons.star,
  //                                           color: Colors.orange,
  //                                         ),
  //                                         Text(
  //                                           comment.rating.toStringAsFixed(1),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   child: Column(
  //                     children: [
  //                       const Text(
  //                         'Añadir comentario',
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 10),
  //                       TextField(
  //                         controller: _commentController,
  //                         decoration: const InputDecoration(
  //                           labelText: 'Escribe tu comentario aquí',
  //                           border: OutlineInputBorder(),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 10),
  //                       Row(
  //                         children: [
  //                           const Text('Rating:'),
  //                           Slider(
  //                             value: _rating,
  //                             onChanged: (value) {
  //                               setState(() {
  //                                 _rating = value;
  //                               });
  //                             },
  //                             min: 0,
  //                             max: 5,
  //                             divisions: 5,
  //                             label: _rating.toString(),
  //                           ),
  //                         ],
  //                       ),
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           if (_commentController.text.isNotEmpty) {
  //                             _addComment(_commentController.text, _rating);
  //                           }
  //                         },
  //                         child: const Text('Enviar'),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
