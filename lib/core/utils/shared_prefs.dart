import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String savePath = "save_path";
  static const String currentFile = "current_file";

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Future<SharedPreferences> get _instance async =>
      await SharedPreferences.getInstance();
  static late SharedPreferences _prefsInstance;

  static String? getString(String key) {
    return _prefsInstance.getString(key);
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> removeKey(String key) async {
    var prefs = await _instance;
    return prefs.remove(key);
  }
}
