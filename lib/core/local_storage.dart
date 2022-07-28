import 'package:shared_preferences/shared_preferences.dart';

Future<void> putData(var value, String key, int type) async {
  final data = await SharedPreferences.getInstance();
  switch (type) {
    case 0:
      await data.setInt(key, value);
      break;
    case 1:
      await data.setBool(key, value);
      break;
    case 2:
      await data.setDouble(key, value);
      break;
    case 3:
      await data.setString(key, value);
      break;
    case 4:
      await data.setStringList(key, value);
      break;
    default:
      await data.setDouble(key, value);
      break;
  }
}

Future<dynamic> getData(String key, int type) async {
  final data = await SharedPreferences.getInstance();
  dynamic output;
  switch (type) {
    case 0:
      output = data.getInt(key);
      break;
    case 1:
      output = data.getBool(key);
      break;
    case 2:
      output = data.getDouble(key);
      break;
    case 3:
      output = data.getString(key);
      break;
    case 4:
      output = data.getStringList(key);
      break;
    default:
      output = data.getDouble(key);
      break;
  }
  return output;
}

Future<bool> deleteData(String key) async {
  final data = await SharedPreferences.getInstance();
  bool success;
  try {
    success = await data.remove(key);
  } catch (e) {
    success = false;
  }
  return success;
}
