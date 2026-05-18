import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class RoleService {
  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  static Future<bool> isClient() async {
    return (await getRole()) == AppConstants.roleClient;
  }

  static Future<bool> isArtisan() async {
    return (await getRole()) == AppConstants.roleArtisan;
  }
}
