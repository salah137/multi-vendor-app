import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static SharedPreferences? sharedPreference;

  static init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static Future putData(key, value) async {
    var x;
    if (value is int){
      sharedPreference!.setInt(key, value);
      x = getDataInt(key);
    }
    else if (value is String){
      sharedPreference!.setString(key, value);
      x = getDataString(key);
    }
    else if (value is bool){
      sharedPreference!.setBool(key, value);
      x = getDataBool(key);
    }
    else if (value is double){ sharedPreference!.setDouble(key, value);
      x = getDataDouble(key);
    }
  print(x);
    print("data is seted");
  }

  static int? getDataInt(
    key,
  ) {
    return sharedPreference!.getInt(key);
  }

  static String? getDataString(
    key,
  ) {
    var value = sharedPreference!.getBool(key);
    return sharedPreference!.getString(key);
  }

  static double? getDataDouble(
    key,
  ) {
    return sharedPreference!.getDouble(key);
  }

  static bool? getDataBool(
    key,
  ) {
    return sharedPreference!.getBool(key);
  }
}
