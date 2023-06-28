import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._();
  static const String ratingField = 'user_rating';
  static const String adStatus = 'ad_status';
  static bool _reviewed = false;
  static void toggle() {
    _reviewed = !_reviewed;
  }
  static Future<bool> get ifReviewed async{
    final prefs = await _sharedPrefs;
    final field = prefs.getInt(ratingField);
    if(field != null){
      return true;
    }
    return _reviewed;
  }

  static Future<SharedPreferences> get _sharedPrefs async {
    return await SharedPreferences.getInstance();
  }

  // Example usage
  static Future<void> setRating(int rating) async {
    final prefs = await _sharedPrefs;
    await prefs.setInt(ratingField, rating);
    toggle();
  }
  static Future<void> setStatusAD(String status) async {
    final prefs = await _sharedPrefs;
    await prefs.setString(adStatus, status);
    toggle();
  }
  static Future<bool> get ifAdAccepted async{
    final prefs = await _sharedPrefs;
    final field = prefs.getString(adStatus);
    if(field != null){
      return true;
    }
    return _reviewed;
  }
}