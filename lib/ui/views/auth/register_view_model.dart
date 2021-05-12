import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';

import 'auth_components.dart';

class RegisterViewModel extends BaseAuthViewModel {
  String firstName;
  String lastName;

  final AuthenticationService _authenticationService;

  RegisterViewModel(NavigationService navigator, this._authenticationService)
      : super(navigator);

  Future<void> register() async => submitAction(() async {
        final String userId = await _authenticationService.register(
          firstName,
          lastName,
          email,
          password,
        );

        if (userId != null && userId.isNotEmpty) {
          navigator.navigateToHomeView();
        }
      });

  void navigateToHomeView() => navigator.navigateToHomeView();
  void navigateToLoginView() => navigator.navigateToLoginInView();
  void pop() => navigator.pop();
}
