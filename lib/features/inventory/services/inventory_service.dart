import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:uuid/uuid.dart';

class InventoryService {
  Future<void> saveProduct(Product product) async {
    try {
      final collection = MongoDBHelper.db.collection('products');
      await collection.insert(product.toMap());
      print('Product saved to MongoDB');
    } catch (e) {
      print('Error saving product: $e');
      rethrow;
    }
  }

  Future<List<Product>> fetchProducts() async {
    try {
      final collection = MongoDBHelper.db.collection('products');
      final products = await collection.find().toList();
      return products.map((data) => Product.fromMap(data)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }

  Future<void> updateProduct(
    String id,
    Map<String, dynamic> updatedData,
  ) async {
    try {
      final collection = MongoDBHelper.db.collection('products');
      await collection.update({'_id': id}, {'\$set': updatedData});
      print('Product updated in MongoDB');
    } catch (e) {
      print('Error updating product: $e');
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final collection = MongoDBHelper.db.collection('products');
      await collection.remove({'_id': id});
      print('Product deleted from MongoDB');
    } catch (e) {
      print('Error deleting product: $e');
      rethrow;
    }
  }

  Future<void> duplicateProductWithChanges({
    required Product originalProduct,
    required DateTime newExpiryDate,
    required int newQuantity,
  }) async {
    try {
      final newProduct = Product(
        id: const Uuid().v4(),
        name: originalProduct.name,
        category: originalProduct.category,
        entryDate: DateTime.now(),
        expiryDate: newExpiryDate,
        grams: originalProduct.grams,
        quantity: newQuantity,
        photoUrl: originalProduct.photoUrl,
        notes: originalProduct.notes,
        entradas: originalProduct.entradas ?? [],
      );
      await saveProduct(newProduct);
      print('Duplicated product saved to MongoDB');
    } catch (e) {
      print('Error duplicating product: $e');
      rethrow;
    }
  }

  Future<void> addQuantityAndExpiry({
    required String productId,
    required int additionalQuantity,
    required DateTime newExpiryDate,
  }) async {
    try {
      final collection = MongoDBHelper.db.collection('products');
      final product = await collection.findOne({'_id': productId});

      if (product != null) {
        // Add a new entry to the "entradas" array
        final newEntry = {
          'entryDate': DateTime.now().toIso8601String(),
          'expiryDate': newExpiryDate.toIso8601String(),
          'grams': null,
          'quantity': additionalQuantity,
        };

        // Update the main fields of the product
        final updatedQuantity =
            (product['quantity'] as int) + additionalQuantity;
        final updatedExpiryDate =
            newExpiryDate.isAfter(
                  DateTime.parse(product['expiryDate'] as String),
                )
                ? newExpiryDate.toIso8601String()
                : product['expiryDate'];

        await collection.updateOne(
          where.eq('_id', productId),
          modify
              .push('entradas', newEntry)
              .set('quantity', updatedQuantity)
              .set('expiryDate', updatedExpiryDate),
        );

        print('Product updated with new entry');
      } else {
        print('Product not found');
      }
    } catch (e) {
      print('Error adding new entry to product: $e');
      rethrow;
    }
  }
}
