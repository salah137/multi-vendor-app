import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static SharedPreferences? sharedPreference;

  static init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static void putData(key, value) async {
    if (value is int)
      sharedPreference!.setInt(key, value);
    else if (value is String)
      sharedPreference!.setString(key, value);
    else if (value is bool)
      sharedPreference!.setBool(key, value);
    else if (value is double) sharedPreference!.setDouble(key, value);
  }

  static int? getDataInt(
    key,
  ) {
    return sharedPreference!.getInt(key);
  }

  static String? getDataString(
    key,
  ) {
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
