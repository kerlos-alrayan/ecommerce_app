import 'package:bloc/bloc.dart';
import 'package:lafyuu/repository/category_repo.dart';
import 'package:meta/meta.dart';
import '../../models/categories_model.dart';
import '../../models/categories_producrs_model.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductsState> {
  CategoryProductCubit() : super(CategoryProductsInitial());

  void getCategoryProducts(int id) async {
    try {
      emit(CategoryProductsLoading());
      final response = await CategoryDetails().getCategoriesDetails(id);
      print("API Response: $response");
      if (response["data"] == null) {
        emit(CategoryProductsFailure(response["message"] ?? "No data found"));
        return;
      }
      final productData = CategoriesProductsModel.fromJson(response);
      print(productData);
      emit(CategoryProductsSuccess(productData));
    } catch (e, stackTrace) {
      print("Error fetching category products: $e");
      print(stackTrace);
      emit(CategoryProductsFailure('Error: $e'));
    }
  }



}
