import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';

class BaseAuthViewModel extends BaseViewModel {
  String email;
  String password;
  String _errorMessage = "";

  final NavigationService navigator;

  BaseAuthViewModel(this.navigator);

  String get errorMessage => _errorMessage;

  bool displayErrorMessage() =>
      _errorMessage != null && _errorMessage.isNotEmpty;

  Future<void> validateAndSubmitAction(AsyncCallback performAction,
      {bool validationPassed}) async {
    _errorMessage = "";
    setBusy(true);

    //Add validation check
      try {
        await performAction();
      } on AuthenticationServiceException catch (exception) {
        _errorMessage = exception.message;
        notifyListeners();
      }
    setBusy(false);
  }

  void navigateToSignIn() => navigator.pop();
}

class NavigateToSignInButton extends StatelessWidget {
  final BaseAuthViewModel model;
  final String buttonText;

  const NavigateToSignInButton(
      {Key key, @required this.buttonText, @required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(buttonText),
        GestureDetector(
          onTap: model.navigateToSignIn,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Sign in',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}