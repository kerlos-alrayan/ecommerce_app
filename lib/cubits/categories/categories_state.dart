// categories_state.dart

import '../../models/categories_model.dart';

abstract class CategoriesState{
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Datum> categories;
  CategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError(this.message);

  @override
  List<Object?> get props => [message];
}
