import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:grocery_app_fe/config/preference.dart';
import 'package:grocery_app_fe/data/authenticate.dart';
import 'package:grocery_app_fe/data/cart_id.dart';
import 'package:grocery_app_fe/data/getQuantity.dart';
import 'package:grocery_app_fe/data/get_product_data.dart';
import 'package:grocery_app_fe/home/ui/home.dart';
import 'package:meta/meta.dart';

import '../../data/cart.dart';
import '../../data/product_data_model.dart';
import '../../data/user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int cost=0;
  HomeBloc() : super(HomeInitial()) {
    on<HomeLogoutEvent>(homeLogoutEvent);
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeGetCartProductQuantityEvent>(homeGetCartProductQuantityEvent);
    on<HomeAddToCartEvent>(homeAddToCartEvent);
    on<HomeUpdateProductInCartEvent>(homeUpdateProductInCartEvent);
    on<HomeNavigateToCartEvent>(homeNavigateToCartEvent);
    on<HomeNavigateToMenuEvent>(homeNavigateToMenuEvent);
    on<HomeCheckUserTokenEvent>(comeCheckUserTokenEvent);

  }

  Future<FutureOr<void>> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {

    List<dynamic> product_data=await fetch_data();
    print(event.user.username);
    dynamic data=await getCart_id(event.user.username);
    print(data);
    Cart cart= new Cart(cart_id: data["cart_id"],user_id:data["user_id"] );
    List<ProductDataModel> productData=[];
    for(int i=0;i<product_data.length;i++){
      if(event.sort=="asc" || event.sort=="dsc"||product_data[i]['type']==event.sort) {
      productData.add(new ProductDataModel(id: product_data[i]['id'],
      name: product_data[i]['name'],
      type: product_data[i]['type'],
      price: product_data[i]['price'],
      quantity: product_data[i]['quantity'],
      imageUrl: product_data[i]['imageurl']));
      }
    }
    for(int i=0;i<productData.length;i++){
      await productData[i].updateQtyCurrent(cart.cart_id);
    }
    if(event.sort=="asc"){
       productData.sort((a, b) => a.name.compareTo(b.name));
    }
    else if (event.sort=="dsc"){
      productData.sort((b, a) => a.name.compareTo(b.name));
    }
    //await Future.delayed(Duration(seconds:3)) ;
    // product_data.map((e) => ProductDataModel(
    //   id: e['id'],
    //   name: e['name'],
    //   type: e['type'],
    //   price: e['quantity']%100,
    //   quantity: e['quantity'],
    //   imageUrl: e['imageurl'],
    // )).toList(),
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 1));
    emit(HomeLoadedSuccessState(cart: cart, products: productData));




      //HLSS.Sort();



      //await Future.delayed(Duration(seconds: 3));

  }

  Future<FutureOr<void>> homeAddToCartEvent(HomeAddToCartEvent event, Emitter<HomeState> emit) async {
    try{
      Dio dio =new Dio();
      Map<String,dynamic>data={
        "username":event.user.username,
        "product_id":event.product_id
      };
      Response response=await dio.put("http://10.0.2.2:8090/addtocart",data:data);
      if (response.statusCode==200){
          emit(HomeAddToCartActionState());
      }
    }
    catch(error){
      print(error);
    }
  }

  Future<FutureOr<void>> homeUpdateProductInCartEvent(HomeUpdateProductInCartEvent event, Emitter<HomeState> emit) async {
    try{
      Dio dio =new Dio();
      dynamic data_1=await getCart_id(event.user.username);
      //print(data);
      Map<String,dynamic>data={
        "cart_id":data_1["cart_id"],
        "product_id":event.product_id,
        "quantity":event.quantity,
      };

      Response response=await dio.put("http://10.0.2.2:8090/updateproductquantity",data:data);
      print(response);
      emit(HomeCartUpdatedActionState());
    }
    catch(error){
      print("hi ${error}");
    }
  }

  FutureOr<void> homeNavigateToCartEvent(HomeNavigateToCartEvent event, Emitter<HomeState> emit) {
  emit(HomeNavigationToCartActionState());
  }

  FutureOr<void> homeNavigateToMenuEvent(HomeNavigateToMenuEvent event, Emitter<HomeState> emit) {
  emit(HomeNavigationToMenuActionState());
  }



  Future<FutureOr<void>> homeGetCartProductQuantityEvent(HomeGetCartProductQuantityEvent event, Emitter<HomeState> emit) async {

  }

  Future<FutureOr<void>> comeCheckUserTokenEvent(HomeCheckUserTokenEvent event, Emitter<HomeState> emit) async {
    dynamic user_returned =await AuthunticateUser(event.user.JWT);
    if(user_returned["username"]!= event.user.username){
      emit(HomeUserTokenExpiredActionState());
    }
  }

  Future<FutureOr<void>> homeLogoutEvent(HomeLogoutEvent event, Emitter<HomeState> emit) async {
   await saveJwtToSharedPreferences("");
   emit(HomeLogoutActionState());
}
}
