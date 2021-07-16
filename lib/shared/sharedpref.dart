import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static SharedPreferences? sharedPreference;
  
  static init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static void putData(key,value) async {
    sharedPreference!.setInt(key, value);
  }

  static int getData(key,)  {
    return sharedPreference!.getInt(key)!;
  }

}