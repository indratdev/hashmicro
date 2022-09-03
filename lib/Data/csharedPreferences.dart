import 'package:shared_preferences/shared_preferences.dart';

class CSharedPreferences {
  SharedPreferences? prefs;

  Future<void> saveLocationMaster(List<String> value) async {
    prefs = await SharedPreferences.getInstance();
    // prefs.setString("username", "naresh");
    prefs?.setStringList(value[0].toString(),
        [value[0].toString(), value[1].toString(), value[2].toString()]);
  }

  getLocationMaster(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    List<String>? stringListValue = prefs.getStringList(value);
    print(stringListValue);
    return stringListValue;
  }

  deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Future<Map<String, dynamic>> getAll() async {
  Future<List<dynamic>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    // final prefsMap = Map<String, dynamic>();
    List<dynamic> prefsMap = [];

    // final ListPrefsMap = [];
    for (String key in keys) {
      prefsMap.add(prefs.get(key));
      // ListPrefsMap.add(prefs.get(key));
    }

    // keys.forEach((element) {
    //   print("=======");
    //   print(element);
    // });

    // print("===> ${prefsMap}");
    return prefsMap;
  }
}
