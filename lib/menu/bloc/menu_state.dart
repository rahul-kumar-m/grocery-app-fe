part of 'menu_bloc.dart';

@immutable
abstract class MenuState {}

abstract class MenuActionState extends MenuState{}

class MenuInitial extends MenuState {}

class MenuLoadedSuccessState extends MenuState{


  final List<Orders> order;
  MenuLoadedSuccessState({required this.order});
}

class MenuOrderViewState extends MenuState{
  final List<ProductDataModel> products;
  final Cart cart;
  MenuOrderViewState({required this.cart,  required this.products});
}

class MenuLogoutActionState extends MenuActionState{}
