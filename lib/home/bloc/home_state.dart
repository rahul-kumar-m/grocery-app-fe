part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}

class HomeLoadedSuccessState extends HomeState{
  final List<ProductDataModel> products;
  final Cart cart;

  HomeLoadedSuccessState({required this.cart,  required this.products,});



}



class HomeLoadedErrorState extends HomeState{}

class HomeAddToCartActionState extends HomeActionState{}

class HomeCartUpdatedActionState extends HomeActionState{}

class  HomeNavigationToCartActionState extends HomeActionState{}

class HomeNavigationToMenuActionState extends HomeActionState{}

class HomeUserTokenExpiredActionState extends HomeActionState{}

class HomeLogoutActionState extends HomeActionState{}