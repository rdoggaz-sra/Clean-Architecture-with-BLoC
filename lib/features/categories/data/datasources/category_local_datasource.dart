import '../../../../core/database/database_helper.dart';
import '../models/category_model.dart';

class CategoryLocalDataSource {
  final dbHelper = DatabaseHelper.instance;

  Future<List<CategoryModel>> getCategories() async {
    final db = await dbHelper.database;
    final result = await db.query('categories');

    return result.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<void> addCategory(CategoryModel category) async {
    final db = await dbHelper.database;

    await db.insert('categories', category.toMap());
  }
}