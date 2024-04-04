import 'package:shared_preferences/shared_preferences.dart';

class AppPref{

setUserToken (String userToken) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("user_token",userToken );
}

Future<String> getUserToken()async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
String userToken= prefs.getString("user_token")??"";
return userToken;
}
removeUserToken ()async{
  final SharedPreferences pref=await SharedPreferences.getInstance();
  pref.remove("user_token");
}
}