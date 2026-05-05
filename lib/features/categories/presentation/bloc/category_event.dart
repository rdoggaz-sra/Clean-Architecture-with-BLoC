import '../../domain/entity/category.dart';

abstract class CategoryEvent {}

class LoadCategories extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final Category category;
  AddCategoryEvent(this.category);
}