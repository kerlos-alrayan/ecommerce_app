part of 'category_product_cubit.dart';

@immutable
abstract class CategoryProductsState {}

class CategoryProductsInitial extends CategoryProductsState {}

class CategoryProductsLoading extends CategoryProductsState {}

class CategoryProductsSuccess extends CategoryProductsState {
  final CategoriesProductsModel homeResponse;
  CategoryProductsSuccess(this.homeResponse);
}
class CategoryProductsFailure extends CategoryProductsState {
  final String error;
  CategoryProductsFailure(this.error);
}
