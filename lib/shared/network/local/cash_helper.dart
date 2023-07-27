import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static SharedPreferences? sharedpref;
  static init() async{
    sharedpref= await SharedPreferences.getInstance();
}

static Future<bool> setValue({
    required String key,
    required  value
})async{
    if(value is String)
      return await sharedpref!.setString(key, value);
    if(value is int)
      return await sharedpref!.setInt(key, value);
    if(value is double)
      return await sharedpref!.setDouble(key, value);
    return await sharedpref!.setBool(key, value);
  }
 static dynamic getCashData({required String key}){
    return sharedpref!.get(key);
  }
  static Future<bool> clearCashData({
    required String key
})async{
   return await sharedpref!.remove(key);
  }
}
