part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState{}


class CartInitial extends CartState {}



class CartLoadedSuccessState extends CartState{
  final List<ProductDataModel> products;
  final Cart cart;
  CartLoadedSuccessState({required this.cart,  required this.products});

}

class CartLoadedErrorState extends CartState{}

class CartUpdatedActionState extends CartActionState{}

class CartPlaceOrderActionState extends CartActionState{}

class CartEmptyCartActionState extends CartActionState{}

class CartUserTokenExpiredActionState extends CartActionState{
}

class CostUpdateCostActionState extends CartActionState{}

class CartLogoutActionState extends CartActionState{}