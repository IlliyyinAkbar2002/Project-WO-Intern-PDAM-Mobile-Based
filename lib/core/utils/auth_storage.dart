/// Simple in-memory auth token storage
/// TODO: Consider using shared_preferences or secure_storage for persistent storage
class AuthStorage {
  static String? _token;
  static Map<String, dynamic>? _user;

  static void saveToken(String token) {
    _token = token;
  }

  static String? getToken() {
    return _token;
  }

  static void saveUser(Map<String, dynamic> user) {
    _user = user;
  }

  static Map<String, dynamic>? getUser() {
    return _user;
  }

  static void clearAuth() {
    _token = null;
    _user = null;
  }

  static bool isLoggedIn() {
    return _token != null;
  }
}
