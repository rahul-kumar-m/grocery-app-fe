part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {

}

class HomeInitialEvent extends HomeEvent{
  final User user;
  String sort="asc";
  HomeInitialEvent(this.sort,{required this.user});
}

class HomeAddToCartEvent extends HomeEvent{
  final int product_id;
  final User user;

  HomeAddToCartEvent({required this.user, required this.product_id});
}

class HomeNavigateToCartEvent extends HomeEvent{


  //HomeNavigateToCartEvent({required this.product_id, required this.user, required this.quantity});
}

class HomeNavigateToMenuEvent extends HomeEvent{}

class HomeUpdateProductInCartEvent extends HomeEvent{
  final int product_id;
  final User user;
  final int quantity;

  HomeUpdateProductInCartEvent({required this.product_id, required this.user, required this.quantity});
}

class HomeGetCartProductQuantityEvent extends HomeEvent{
 final int product_id;
 final String cart_id;
 int quantity=0;
 HomeGetCartProductQuantityEvent({required this.cart_id, required this.product_id});
 int getQuantity(){
   return quantity;
 }

}
class HomeCheckUserTokenEvent extends HomeEvent{
  final User user;
  HomeCheckUserTokenEvent({required this.user});
}

class HomeLogoutEvent extends HomeEvent{}