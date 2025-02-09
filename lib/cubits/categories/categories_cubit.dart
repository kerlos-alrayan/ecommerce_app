// categories_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/categories_model.dart';
import '../../repository/category_repo.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {

  CategoriesCubit() : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final response = await CategoryRepository().getAllCategories();
      final categoriesModel = CategoriesModel.fromJson(response.data);
      emit(CategoriesLoaded(categoriesModel.data.data));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}