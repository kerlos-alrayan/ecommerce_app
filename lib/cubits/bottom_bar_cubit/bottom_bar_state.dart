abstract class BottomBarState {
  final int index;
  BottomBarState(this.index);
}

class BottomBarInitial extends BottomBarState {
  BottomBarInitial(): super(0);
}

class BottomBarChange extends BottomBarState {
  BottomBarChange(super.index);
}


