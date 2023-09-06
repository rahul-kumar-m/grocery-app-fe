import 'package:dio/dio.dart';


Future<dynamic> AuthunticateUser(JW_TOKEN) async {
  try{
    Dio dio=new Dio();
    Map<String,dynamic> data={
      "jwt":JW_TOKEN,
    };
    Response response=await dio.put("http://10.0.2.2:8090/authUser",data:data);
    print(response.data);
    if(response.statusCode==200){
      print(response.data);
      return {"username": response.data["username"],"password": response.data["password"]};
    }
    return {};


  }
  catch(error){
    print(error);
    return {};
  }




}