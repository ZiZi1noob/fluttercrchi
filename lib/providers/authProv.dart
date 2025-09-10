import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _username = '';
  String _password = '';
  final _usernameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String get username => _username;
  String get password => _password;
  GlobalKey<FormState> get usernameFormKey => _usernameFormKey;
  GlobalKey<FormState> get passwordFormKey => _passwordFormKey;
  bool get isLoading => _isLoading;

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    final isUsernameValid = _usernameFormKey.currentState?.validate() ?? false;
    final isPasswordValid = _passwordFormKey.currentState?.validate() ?? false;
    if (!isUsernameValid || !isPasswordValid) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Hello, $_username!')));
    }
    _isLoading = false;
    notifyListeners();
  }
}
