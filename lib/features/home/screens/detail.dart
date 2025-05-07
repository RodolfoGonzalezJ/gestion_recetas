import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/Comment/models/models.dart';
import 'package:gestion_recetas/features/recipes/services/recipe_service.dart';

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
                        'Description',
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
                        'Ingredients',
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
                      const Text(
                        'Comments',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...comments.map((comment) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              comment.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comment.content),
                                const SizedBox(height: 4),
                                Text('Rating: ${comment.rating}'),
                              ],
                            ),
                          ),
                        );
                      }).toList(),

                      const SizedBox(height: 20),

                      // Añadir comentario
                      const Text(
                        'Add a Comment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          labelText: 'Write your comment...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Rating:'),
                          Slider(
                            value: _rating,
                            onChanged: (value) {
                              setState(() {
                                _rating = value;
                              });
                            },
                            min: 0,
                            max: 5,
                            divisions: 5,
                            label: _rating.toString(),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_commentController.text.isNotEmpty) {
                            _addComment(_commentController.text, _rating);
                          }
                        },
                        child: const Text('Submit'),
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
}
