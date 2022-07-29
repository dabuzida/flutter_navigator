import 'package:shared_preferences/shared_preferences.dart';

class SharedStoreKey {
  static const String appVersion = 'app_version';

  static const String loginId = 'login_id';
  static const String userId = 'user_id';
  static const String userTicket = 'user_ticket';
}

class SharedStore {
  SharedStore._();

  static Future<void> set(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    }
  }

  static Future<void> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key); //return prefs.getInt(key) ?? 0;
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key); //return prefs.getInt(key) ?? '';
  }

  static dynamic getStringList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key); //return prefs.getInt(key) ?? [];
  }

  static Future<void> clearAll() async {
    await SharedStore.remove(SharedStoreKey.loginId);
    await SharedStore.remove(SharedStoreKey.userId);
    await SharedStore.remove(SharedStoreKey.userTicket);
  }
}
