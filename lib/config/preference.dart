
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getJwtFromSharedPreferences() async {
  try{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }
  catch(error){
    print(error);
  }
}
Future<void> saveJwtToSharedPreferences(String jwt) async {
  try{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt', jwt);
  }
  catch(error){
    print(error);
  }
}