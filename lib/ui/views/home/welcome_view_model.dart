import 'package:stacked/stacked.dart';
import 'package:work_around/services/navigation_service.dart';

class WelcomeViewModel extends BaseViewModel{
  final NavigationService _navigationService;

  WelcomeViewModel(this._navigationService);

  void navigateToLoginView() => _navigationService.navigateToLoginInView();
  void navigateToRegisterView() => _navigationService.navigateToRegisterView();

}