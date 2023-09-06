part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState{}

class LoginInitial extends LoginState {}

class LoginUserNotFoundActionState extends LoginActionState{}

class LoginPasswordIncorrectActionState extends LoginActionState{}

class LoginSuccessfulActionState extends LoginActionState{}

class LoginForwardToProductPageActionState extends LoginActionState{
  final User user;
  LoginForwardToProductPageActionState({required this.user});
}

class LoginLoadedState extends LoginState{}

class LoginPageErrorState extends LoginState{}
