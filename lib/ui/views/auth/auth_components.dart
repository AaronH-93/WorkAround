import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/services/navigation_service.dart';

class BaseAuthViewModel extends BaseViewModel {
  String email;
  String password;
  String _errorMessage = "";

  final NavigationService navigator;

  BaseAuthViewModel(this.navigator);

  String get errorMessage => _errorMessage;

  bool displayErrorMessage() => _errorMessage != null && _errorMessage.isNotEmpty;

  Future<void> submitAction(AsyncCallback performAction) async {
    _errorMessage = "";
    setBusy(true);
      try {
        await performAction();
      } catch(exception) {
        _errorMessage = exception.toString();
        notifyListeners();
      }
    setBusy(false);
  }

  void navigateToSignIn() => navigator.pop();
}