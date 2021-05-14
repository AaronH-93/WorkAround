import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'auth_components.dart';

class LoginViewModel extends BaseAuthViewModel {
  final AuthenticationService _authenticationService;

  LoginViewModel(this._authenticationService, NavigationService navigator)
      : super(navigator);

  void navigateToHomeView() => navigator.navigateToHomeView();
  void navigateToResetPasswordView() => navigator.navigateToResetPasswordView();
  void navigateToRegisterView() => navigator.navigateToRegisterView();
  void pop() => navigator.pop();

  Future<void> submitSignIn(String email, String password) async =>
      submitAction(() async {
        final String userId = await _authenticationService.signIn(email, password);
        if (userId != null && userId.isNotEmpty) {
          navigator.navigateToHomeView();
        }
      });
}
