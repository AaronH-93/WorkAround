import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/ui/views/auth/auth_components.dart';

class ResetPasswordViewModel extends BaseAuthViewModel{
  final AuthenticationService _authenticationService;
  String email;

  ResetPasswordViewModel(this._authenticationService, NavigationService navigator) : super(navigator);

  Future<void> submitPasswordReset() async =>
      submitAction(() async {
        await _authenticationService.passwordReset(email);
        navigateToSignIn();
      });

  void navigateToLoginView() => navigator.navigateToLoginInView();
  void navigateToRegisterView() => navigator.navigateToRegisterView();
}