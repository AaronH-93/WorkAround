import 'package:stacked/stacked.dart';
import 'package:work_around/services/navigation_service.dart';

class AboutViewModel extends BaseViewModel{
  final NavigationService _navigationService;

  AboutViewModel(this._navigationService);


  void navigateToHomeView() => _navigationService.navigateToHomeView();
}