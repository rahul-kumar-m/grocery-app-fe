import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'thankyou_event.dart';
part 'thankyou_state.dart';

class ThankyouBloc extends Bloc<ThankyouEvent, ThankyouState> {
  ThankyouBloc() : super(ThankyouInitial()) {
    on<ThankYouInitialEvent>(thankYouInitialEvent);



}
  Future<FutureOr<void>> thankYouInitialEvent(ThankYouInitialEvent event, Emitter<ThankyouState> emit) async {
  emit(ThankYouLoadedState());
  await Future.delayed(Duration(seconds: 1));
  emit(ThankYouForwardActionState());
  }
}
