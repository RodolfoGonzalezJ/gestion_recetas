class Comment {
  final String id;
  final String recipeId;
  final String userId;
  final String content;
  final double rating;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.recipeId,
    required this.userId,
    required this.content,
    required this.rating,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'recipeId': recipeId,
      'userId': userId,
      'content': content,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['_id'] as String,
      recipeId: map['recipeId'] as String,
      userId: map['userId'] as String,
      content: map['content'] as String,
      rating: map['rating'] as double,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}