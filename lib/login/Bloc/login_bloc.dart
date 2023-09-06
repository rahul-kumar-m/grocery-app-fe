import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:grocery_app_fe/data/user.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/preference.dart';
import '../../data/authenticate.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginLoadingEvent>(loginLoadingEvent);
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<InitialLoginCheck>(initialLoginCheck);
  }

  Future<FutureOr<void>> loginLoadingEvent(LoginLoadingEvent event, Emitter<LoginState> emit) async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    this.add(InitialLoginCheck());
    emit(LoginLoadedState());
  }

  Future<FutureOr<void>> loginButtonClickedEvent (LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
      try{

        Dio dio=new Dio();
      //print(event.user);
      String url = 'http://10.0.2.2:8090/login';
      Map<String, dynamic> postData = {
        'username': event.user.username,
        'password': event.user.password,
      };
      print(postData);


        // Make the POST request
        Response response = await dio.post(url, data: postData);

        // Handle the response
        if (response.statusCode == 200) {
          print('POST request successful: ${response.data}');
          if (response.data=="NoUser"){
            emit(LoginUserNotFoundActionState());
          }
          else if(response.data=="error"){
            emit(LoginPasswordIncorrectActionState());
          }
          else{
            emit(LoginSuccessfulActionState());
            event.user.assignJWT(response.data["accessToken"]);
            saveJwtToSharedPreferences(response.data["accessToken"]);
            await Future.delayed(Duration(seconds: 1));
            emit(LoginForwardToProductPageActionState(user:event.user));
          }

        }
        else {
          print('POST request failed with status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error making POST request: $error');
      }
  }

  Future<FutureOr<void>> initialLoginCheck(InitialLoginCheck event, Emitter<LoginState> emit) async {
    try{
      dynamic jwt=await getJwtFromSharedPreferences();
      print("HIpref");
      if (jwt!=""){
        dynamic data=await AuthunticateUser(jwt);
        if (data!={}){
          print("Hi");
          User user =new User(username:data["username"],password:data["password"]);
          user.assignJWT(jwt);
          emit(LoginForwardToProductPageActionState(user: user));
        }
      }

    }
    catch(error){
      print(error);
    }
  }
}
