class Product {
  final String id;
  final String name;
  final String category;
  final DateTime entryDate;
  final DateTime expiryDate;
  final double? grams; // Optional
  final int quantity;
  final String? photoUrl; // Optional
  final String? notes; // Optional

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.entryDate,
    required this.expiryDate,
    this.grams,
    required this.quantity,
    this.photoUrl,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'category': category,
      'entryDate': entryDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'grams': grams,
      'quantity': quantity,
      'photoUrl': photoUrl,
      'notes': notes,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String,
      name: map['name'] as String? ?? 'Sin nombre',
      category: map['category'] as String? ?? 'Sin categoría',
      entryDate: DateTime.parse(map['entryDate'] as String),
      expiryDate: DateTime.parse(map['expiryDate'] as String),
      grams: map['grams'] != null ? (map['grams'] as num).toDouble() : null,
      quantity: map['quantity'] as int? ?? 0,
      photoUrl: map['photoUrl'] as String?,
      notes: map['notes'] as String?,
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
