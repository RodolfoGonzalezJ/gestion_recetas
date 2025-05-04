import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/Comment/controllers/controllers.dart';
import 'package:gestion_recetas/features/Comment/models/models.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final String recipeId;

  const CommentScreen({Key? key, required this.recipeId}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 3.0;

  @override
  void initState() {
    super.initState();
    Provider.of<CommentController>(context, listen: false)
        .loadComments(widget.recipeId);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    if (_commentController.text.isEmpty) return;

    final newComment = Comment(
      id: '',
      recipeId: widget.recipeId,
      userId: 'user123', // Replace with actual user ID
      content: _commentController.text,
      rating: _rating,
      createdAt: DateTime.now(),
    );

    await Provider.of<CommentController>(context, listen: false)
        .addComment(newComment);

    _commentController.clear();
    setState(() {
      _rating = 3.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final comments = Provider.of<CommentController>(context).comments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comentarios y Calificaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return ListTile(
                    title: Text(comment.content),
                    subtitle: Row(
                      children: [
                        Text('Calificación: ${comment.rating.toStringAsFixed(1)}'),
                        const SizedBox(width: 8),
                        Text(
                          'Por: ${comment.userId}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Text(
                      comment.createdAt.toLocal().toString().split(' ')[0],
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Escribe un comentario',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Calificación:'),
                Slider(
                  value: _rating,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _rating.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _submitComment,
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}