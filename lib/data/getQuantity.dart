import 'package:dio/dio.dart';

Future<int> getQuantity(cartid,int productid) async {
  Dio dio=new Dio();
  try{
    Map<String,dynamic> headers={
      "cart_id":cartid,
      "product_id":productid,
    };
    Options options=new Options(headers: headers);
    Response response = await dio.get("http://10.0.2.2:8090/getQuantity",options: options);
    return response.data;
  }
  catch(error){
    print(error);
    return 0;
  }

}