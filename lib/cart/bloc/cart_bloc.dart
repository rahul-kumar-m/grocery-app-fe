import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:grocery_app_fe/home/bloc/home_bloc.dart';
import 'package:meta/meta.dart';

import '../../config/preference.dart';
import '../../data/authenticate.dart';
import '../../data/cart.dart';
import '../../data/cart_id.dart';
import '../../data/fetch_cart_data.dart';
import '../../data/product_data_model.dart';
import '../../data/user.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  int cost=0;
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartUpdateProductInCartEvent>(cartUpdateProductInCartEvent);
    on<CartPlaceOrderEvent>(cartPlaceOrderEvent);
    on<CartCheckUserTokenEvent>(cartCheckUserTokenEvent);
    on<CartUpdateCost>(cartUpdateCost);
    on<CartLogoutEvent>(cartLogoutEvent);
  }

  Future<FutureOr<void>> cartCheckUserTokenEvent(CartCheckUserTokenEvent event, Emitter<CartState> emit) async {
    dynamic user_returned =await AuthunticateUser(event.user.JWT);
    if(user_returned["username"]!= event.user.username){
      emit(CartUserTokenExpiredActionState());
    }

  }

  FutureOr<void> cartUpdateCost(CartUpdateCost event, Emitter<CartState> emit) {
      this.cost+=event.update;
      emit(CostUpdateCostActionState());
  }

  Future<FutureOr<void>> cartLogoutEvent(CartLogoutEvent event, Emitter<CartState> emit) async {
    await saveJwtToSharedPreferences("");
    emit(CartLogoutActionState());

  }
}


  Future<FutureOr<void>> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) async {
    //emit(HomeLoadingState());

    print(event.user.username);
    dynamic data=await getCart_id(event.user.username);
    print(data);
    List<dynamic> product_data=await fetch_cart_data(data["cart_id"]);
    Cart cart= new Cart(cart_id: data["cart_id"],user_id:data["user_id"] );

    //await Future.delayed(Duration(seconds:3)) ;
    CartLoadedSuccessState HLSS=new CartLoadedSuccessState(products: product_data.map((e) => ProductDataModel(
      id: e['id'],
      name: e['name'],
      type: e['type'],
      price: e['price'],
      quantity: e['quantity'],
      imageUrl: e['imageurl'],
    )).toList(),
        cart:cart
    );


    for(int i=0;i<HLSS.products.length;i++){
      await HLSS.products[i].updateQtyCurrent(HLSS.cart.cart_id);
    }
    emit(HLSS);
  }

  Future<FutureOr<void>> cartPlaceOrderEvent(CartPlaceOrderEvent event, Emitter<CartState> emit) async {
    Dio dio=new Dio();

    try{
      dynamic data_cart=await getCart_id(event.user.username);
      //print(data);
      Map<String,dynamic> data={
        "username":event.user.username,
        "cart_id": data_cart["cart_id"]
      };
      print("hi${data}");
      Response response=await dio.post("http://10.0.2.2:8090/placeorder",data:data);
      print(response.data=="false");
      if (response.statusCode==200){
        if (response.data=="true") {
          emit(CartPlaceOrderActionState());
        }
        else if (response.data=="false"){
          emit(CartEmptyCartActionState());
        }
      }

    }
    catch(error){
      print(error);

    }
  }

Future<FutureOr<void>> cartUpdateProductInCartEvent(CartUpdateProductInCartEvent event, Emitter<CartState> emit) async {
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
    emit(CartUpdatedActionState());
  }
  catch(error){
    print("hi ${error}");
  }
}
