part of 'thankyou_bloc.dart';

@immutable
abstract class ThankyouState {}

abstract class ThankYouActionState extends ThankyouState{}

class ThankyouInitial extends ThankyouState {}

class ThankYouLoadedState extends ThankyouState{}

class ThankYouForwardActionState extends ThankYouActionState{}
