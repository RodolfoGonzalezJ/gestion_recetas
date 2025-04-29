import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';

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
}
