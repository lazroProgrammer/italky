import 'package:shared_preferences/shared_preferences.dart';

class SimplePreferences {
  // static SharedPreferences _preferences= SharedPreferences.getInstance();
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static const isLoggedKey = 'login';

  static const userIdKey = 'UserId';
  static const usernameKey = 'Username';
  static const userEmailKey = 'User email';

  static const colorOfFriendRequestKey = "colorRequestKey";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLogin(bool logged) async {
    await _preferences.setBool(isLoggedKey, logged);
  }

  static bool? getLogin() => _preferences.getBool(isLoggedKey);

  static Future setUserId(String? id)async{
    if (id == null) {
      _preferences.remove(userIdKey);
    } else {
      await _preferences.setString(userIdKey, id);
    }
  }

  static String? getUserId() => _preferences.getString(userIdKey);

  static Future setUsername(String? name) async {
    if (name == null) {
      _preferences.remove(usernameKey);
    } else {
      await _preferences.setString(usernameKey, name);
    }
  }

  static String? getUsername() => _preferences.getString(usernameKey);

  static Future setUserEmail(String? email) async {
    if (email == null) {
      _preferences.remove(userEmailKey);
    } else {
      await _preferences.setString(userEmailKey, email);
    }
  }

  static Future setFriendReqColor(int? temp) async {
    if (temp == null) {
      _preferences.remove(colorOfFriendRequestKey);
    } else {
      await _preferences.setInt(colorOfFriendRequestKey, temp);
    }
  }

  static String? getUserEmail() => _preferences.getString(userEmailKey);

  static int? getColorOfFriendRequest() =>
      _preferences.getInt(colorOfFriendRequestKey);
}
