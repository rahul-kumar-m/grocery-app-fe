part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent {}

class MenuInitialEvent extends MenuEvent{
  final User user;
  MenuInitialEvent({required this.user});
}

class MenuCheckUserTokenEvent extends MenuEvent{
  final User user;
  MenuCheckUserTokenEvent({required this.user});
}

class MenuOrderViewEvent extends MenuEvent{
  final User user;
  final String cart_id;

  MenuOrderViewEvent({required this.cart_id, required this.user});
}

class MenuLogoutEvent extends MenuEvent{}