
import 'package:dio/dio.dart';

dynamic fetch_cart_data(cart_id) async {
  List<Map<String,dynamic>> product_data=[];

  try{
    Dio dio=new Dio();
    String url="http://10.0.2.2:8090/getCartProducts";
    print(1);
    Map<String,dynamic> headers={
      "cart_id":cart_id
    } ;
    Options options=new Options(headers: headers);
    Response response=await dio.get(url,options: options);
    print(2);
    //print(response.data);
    for(int i=0;i<response.data.length;i++){
      product_data.add({
        "id":response.data[i]["product_id"],
        "quantity":response.data[i]["quantity_tot"],
        "name":response.data[i]["name"],
        "type":response.data[i]["type"],
        "price":int.parse(response.data[i]['price']),
        "imageurl":response.data[i]["imageurl"],
      });
    }
    //await Future.delayed(Duration(seconds: 2));

    //print(jsonDecode(response.data));
    //print(product_data);
    return product_data;
  }
  catch(error){
    print("Hi1");
    print(error);
    return product_data;
  }
}