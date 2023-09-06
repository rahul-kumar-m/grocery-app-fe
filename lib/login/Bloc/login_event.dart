part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent{
  final User user;
  LoginButtonClickedEvent({required this.user});
}

class LoginLoadingEvent extends LoginEvent{}

class InitialLoginCheck extends LoginEvent{}