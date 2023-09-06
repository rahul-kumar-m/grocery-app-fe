import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:grocery_app_fe/config/preference.dart';
import 'package:meta/meta.dart';

import '../../data/cart.dart';
import '../../data/cart_id.dart';
import '../../data/get_product_data.dart';
import '../../data/order.dart';
import '../../data/product_data_model.dart';
import '../../data/user.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  int cost=0;
  MenuBloc() : super(MenuInitial()) {
   on<MenuInitialEvent>(menuInitialEvent);
   on<MenuOrderViewEvent>(menuOrderViewEvent);
   on<MenuLogoutEvent>(menuLogoutEvent);
  }


  Future<FutureOr<void>> menuOrderViewEvent(MenuOrderViewEvent event, Emitter<MenuState> emit) async {
    List<dynamic> product_data=await fetch_data();
    print(event.user.username);
    dynamic data=await getCart_id(event.user.username);
    //print(data);

    Cart cart= new Cart(cart_id: event.cart_id,user_id:data["user_id"] );


    //await Future.delayed(Duration(seconds:3)) ;
    MenuOrderViewState HLSS=new MenuOrderViewState(products: product_data.map((e) => ProductDataModel(
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

  Future<FutureOr<void>> menuLogoutEvent(MenuLogoutEvent event, Emitter<MenuState> emit) async {
    await saveJwtToSharedPreferences("");
    emit(MenuLogoutActionState());
  }
}

Future<FutureOr<void>> menuInitialEvent(MenuInitialEvent event, Emitter<MenuState> emit) async {
  try{

    Dio dio =new Dio();
    dynamic data=await getCart_id(event.user.username);
    Map<String,String> headers={
      "username":event.user.username,
    };
    Options options=new Options(headers: headers);
    Response response =await dio.get("http://10.0.2.2:8090/orders",options: options);
    print(response.data);
    if (response.statusCode==200){
      if (response.data==false) {
        return [];
      }
      else{

        List<Orders> orders=[];
        for(int i=0;i<response.data.length;i++){
              orders.add(
                new Orders(cart_id: response.data[i]['cart_id'],
                    no_of_products: response.data[i]['product_count'],
                    price: int.parse(response.data[i]['price'])
                )
              );
        }

        emit(MenuLoadedSuccessState( order:orders));
      }
    }

  }
  catch(error){
    print(error);
    return false;
  }


}
