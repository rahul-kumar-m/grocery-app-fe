part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent{
  final User user;
  CartInitialEvent({required this.user});
}

class CartUpdateProductInCartEvent extends CartEvent{
  final int product_id;
  final User user;
  final int quantity;
  CartUpdateProductInCartEvent({required this.product_id, required this.user, required this.quantity});
}

class CartPlaceOrderEvent extends CartEvent{
  final User user;
  CartPlaceOrderEvent({required this.user});
}

class CartCheckUserTokenEvent extends CartEvent{
  final User user;
  CartCheckUserTokenEvent({required this.user});
}

class CartUpdateCost extends CartEvent{
  final int update;
  CartUpdateCost({required this.update});

}

class CartLogoutEvent extends CartEvent{}