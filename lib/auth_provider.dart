import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {

    _isLoading = true;
    notifyListeners();

    if (email == 'admin' && password == 'admin') {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }

    _isLoading = false;
    notifyListeners();

    return _isAuthenticated;
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}