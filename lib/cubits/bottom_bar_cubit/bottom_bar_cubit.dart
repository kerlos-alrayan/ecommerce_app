import 'package:lafyuu/cubits/bottom_bar_cubit/bottom_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarCubit extends Cubit<BottomBarState>{
  BottomBarCubit(): super(BottomBarInitial());

  void changeIndex(int index){
    emit(BottomBarChange(index));
  }
}