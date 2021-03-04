import 'package:stacked/stacked.dart';
import 'package:work_around/services/navigation_service.dart';

class LoginViewModel extends BaseViewModel{
  String _title = 'Login View';
  String get title => _title;

  final NavigationService _navigationService;

  LoginViewModel(this._navigationService);

  void navigateToHomeView() => _navigationService.navigateToHomeView();
  void pop() => _navigationService.pop();
}