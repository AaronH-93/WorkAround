import 'package:stacked/stacked.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';

import 'auth_components.dart';

class RegisterViewModel extends BaseAuthViewModel{
  String firstName;
  String lastName;

  final AuthenticationService _authenticationService;

  RegisterViewModel(NavigationService navigator, this._authenticationService) : super(navigator);

  Future<void> validateAndRegister({bool validationPassed}) async =>
      validateAndSubmitAction(() async {
        final String userId = await _authenticationService.register(
          firstName,
          lastName,
          email,
          password,
        );

        if (userId != null && userId.isNotEmpty) {
          navigator.navigateToHomeView();
        }
      }, validationPassed: validationPassed);

  void navigateToHomeView() => navigator.navigateToHomeView();
  void pop() => navigator.pop();

}