import 'package:shared_preferences/shared_preferences.dart';

class sharedPreference {
  Future<void> addStringToSF(String countryName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', countryName);
  }

  Future<String?> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('stringValue');
    return stringValue;
  }
}
