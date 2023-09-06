
import 'package:dio/dio.dart';

Future<dynamic> getCart_id(username) async {
  print("Hi");
  try{

    Dio dio=new Dio();
    Map<String,String> data={
      "username":username
    };
    Response response =await dio.post("http://10.0.2.2:8090/getcart",data: data);
    print("response data");

    return response.data;
  }
  catch(error){
    print(error);
     return {};
  }


}
Future<dynamic> getCart_id_status(username) async {
  print("Hi");
  try{

    Dio dio=new Dio();
    Map<String,String> data={
      "username":username
    };
    Response response =await dio.post("http://10.0.2.2:8090/getcart",data: data);
    print("response data");
    print(response.data);
    return response.data;
  }
  catch(error){
    print(error);
    return {};
  }


}