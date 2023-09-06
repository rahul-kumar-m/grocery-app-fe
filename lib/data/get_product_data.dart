import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:grocery_app_fe/data/product_data_model.dart';




Future<dynamic> fetch_data() async {
  List<Map<String,dynamic>> product_data=[];

  try{
      Dio dio=new Dio();
      String url="http://10.0.2.2:8090/productdetails";
      Response response=await dio.get(url);
      for(int i=0;i<response.data.length;i++){
        product_data.add({
          "id":response.data[i]["product_id"],
          "quantity":response.data[i]["quantity_tot"],
          "name":response.data[i]["name"],
          "type":response.data[i]["type"],
          "price":int.parse(response.data[i]["price"]),
          "imageurl":response.data[i]["imageurl"],
        });
      }
      print(product_data);
      //await Future.delayed(Duration(seconds: 2));

      //print(jsonDecode(response.data));
      //print(product_data);
      return product_data;
    }
    catch(error){
    print("Hi");
      print(error);
      return product_data;
    }
  }


