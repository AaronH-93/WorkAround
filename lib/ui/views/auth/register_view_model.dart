import 'package:stacked/stacked.dart';
import 'package:work_around/services/navigation_service.dart';

class RegisterViewModel extends BaseViewModel{
  String _title = 'Register View';
  String get title => _title;

  final NavigationService _navigationService;

  RegisterViewModel(this._navigationService);

  void navigateToHomeView() => _navigationService.navigateToHomeView();
  void pop() => _navigationService.pop();
}