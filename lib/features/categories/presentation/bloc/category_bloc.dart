import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_category.dart';
import '../../domain/usecases/get_categories.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories getCategories;
  final AddCategory addCategory;

  CategoryBloc({
    required this.getCategories,
    required this.addCategory,
  }) : super(CategoryInitial()) {

    on<LoadCategories>((event, emit) async {
      final categories = await getCategories();
      emit(CategoryLoaded(categories));
    });

    on<AddCategoryEvent>((event, emit) async {
      await addCategory(event.category);
      final categories = await getCategories();
      emit(CategoryLoaded(categories));
    });
  }
}