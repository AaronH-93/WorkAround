import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/ui/views/auth/reset_password_view_model.dart';
import '../../../constants.dart';

class ResetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      key: Key('resetPasswordView'),
      builder: (context, model, child){
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'WorkAround',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              _EmailField(),
              _CompleteButton(),
              TextButton(
                key: Key('redirectToLoginButton'),
                child: Text('Remembered your password?'),
                onPressed: (){
                  model.navigateToLoginView();
                  },
              ),
              TextButton(
                key: Key('redirectToRegisterButton'),
                child: Text('Don\'t have an account?'),
                onPressed: (){
                  model.navigateToRegisterView();
                },
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => ResetPasswordViewModel(
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<NavigationService>(context, listen: false),
      ),
    );
  }
}

class _CompleteButton extends ViewModelWidget<ResetPasswordViewModel> {

  @override
  Widget build(BuildContext context, ResetPasswordViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: RoundedButton(
        widgetKey: Key('resetPasswordButton'),
        color: Colors.redAccent,
        title: 'Reset Password',
        onPressed: (){
          model.submitPasswordReset();
        },
      ),
    );
  }
}

class _EmailField extends ViewModelWidget<ResetPasswordViewModel> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context, ResetPasswordViewModel model) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: TextField(
            key: Key('emailField'),
            controller: controller,
              decoration: kTextFieldDecoration.copyWith(
                hintStyle: TextStyle(color: Colors.white),
              ),
            onChanged: (value) {
              model.email = value;
            },
          ),
        ));
  }
}