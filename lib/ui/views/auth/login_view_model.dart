import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';

import 'auth_components.dart';

class LoginViewModel extends BaseAuthViewModel{
  final AuthenticationService _authenticationService;

  LoginViewModel(this._authenticationService, NavigationService navigator) : super(navigator);

  void navigateToHomeView() => navigator.navigateToHomeView();
  void pop() => navigator.pop();

  //add validation check
  Future<void> validateAndSubmitSignIn(String email, String password) async =>
      validateAndSubmitAction(() async {
        final String userId = await _authenticationService.signIn(email, password);
        if (userId != null && userId.isNotEmpty) {
          navigator.navigateToHomeView();
        }
      }
      );

  void navigateToSignUp() => navigator.navigateToRegisterView();

}