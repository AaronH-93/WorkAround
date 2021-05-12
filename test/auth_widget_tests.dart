import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/ui/views/auth/login_view.dart';
import 'package:work_around/ui/views/auth/login_view_model.dart';
import 'package:work_around/ui/views/auth/register_view.dart';
import 'package:work_around/ui/views/auth/register_view_model.dart';
import 'package:work_around/ui/views/auth/reset_password_view.dart';
import 'package:work_around/ui/views/auth/reset_password_view_model.dart';
import 'package:work_around/ui/views/home/welcome_view.dart';
import 'package:work_around/ui/views/home/welcome_view_model.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver{}
class MockWelcomeViewModel extends Mock implements WelcomeViewModel{}
class MockLoginViewModel extends Mock implements LoginViewModel{}
class MockRegisterViewModel extends Mock implements RegisterViewModel{}
class MockResetPasswordViewModel extends Mock implements ResetPasswordViewModel{}
class MockNavigationService extends Mock implements NavigationService{}
class MockAuthenticationService extends Mock implements AuthenticationService{}

void main() {
  final mockNavigationService = MockNavigationService();
  final mockAuth = MockAuthenticationService();
  final mockObserver = MockNavigatorObserver();

  final redirectToLoginButton = find.byKey(ValueKey('redirectToLoginButton'));
  final redirectToRegisterButton = find.byKey(ValueKey('redirectToRegisterButton'));
  final redirectToResetPasswordButton = find.byKey(ValueKey('redirectToResetPasswordButton'));

  Widget _createWelcomeTestWidget({Widget view}) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      builder: (context, model, child) => MaterialApp(
        home: view,
        navigatorObservers: [mockObserver],
      ),
      viewModelBuilder: () => WelcomeViewModel(mockNavigationService),
    );
  }

  Widget _createLoginTestWidget({Widget view}) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => MaterialApp(
        home: view,
        navigatorObservers: [mockObserver],
      ),
      viewModelBuilder: () => MockLoginViewModel(),
    );
  }

  Widget _createRegisterTestWidget({Widget view}) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      builder: (context, model, child) => MaterialApp(
        home: view,
        navigatorObservers: [mockObserver],
      ),
      viewModelBuilder: () => MockRegisterViewModel(),
    );
  }

  Widget _createResetPasswordTestWidget({Widget view}) {
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      builder: (context, model, child) => MaterialApp(
        home: view,
        navigatorObservers: [mockObserver],
      ),
      viewModelBuilder: () => MockResetPasswordViewModel(),
    );
  }

  Future<Null> _buildRegisterView(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<NavigationService>.value(
            value: mockNavigationService,
          ),
          Provider<AuthenticationService>.value(
            value: mockAuth,
          ),
        ],
        child: Builder(
            builder: (_) => _createRegisterTestWidget(view: RegisterView())
        ),
      ),
    );
    verify(mockObserver.didPush(any, any));
  }

  Future<Null> _buildResetPasswordView(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<NavigationService>.value(
            value: mockNavigationService,
          ),
          Provider<AuthenticationService>.value(
            value: mockAuth,
          ),
        ],
        child: Builder(
            builder: (_) => _createResetPasswordTestWidget(view: ResetPasswordView())
        ),
      ),
    );
    verify(mockObserver.didPush(any, any));
  }

  Future<Null> _buildLoginView(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<NavigationService>.value(
            value: mockNavigationService,
          ),
          Provider<AuthenticationService>.value(
            value: mockAuth,
          ),
        ],
        child: Builder(
            builder: (_) => _createLoginTestWidget(view: LoginView())
        ),
      ),
    );
    verify(mockObserver.didPush(any, any));
  }

  Future<Null> _buildWelcomeView(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<NavigationService>.value(
            value: mockNavigationService,
          ),
        ],
        child: Builder(
            builder: (_) => _createWelcomeTestWidget(view: WelcomeView())
        ),
      ),
    );
    verify(mockObserver.didPush(any, any));
  }

  testWidgets('WelcomeView widget test', (WidgetTester tester) async {
    final loginButton = find.byKey(ValueKey('loginButton'));
    final registerButton = find.byKey(ValueKey('registerButton'));

    await _buildWelcomeView(tester);

    expect(loginButton, findsOneWidget);
    expect(registerButton, findsOneWidget);
  });

  testWidgets('LoginView widget test', (WidgetTester tester) async {
    final emailField = find.byKey(ValueKey('emailField'));
    final passwordField = find.byKey(ValueKey('passwordField'));
    final submitButton = find.byKey(ValueKey('submit'));

    await _buildLoginView(tester);

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(submitButton, findsOneWidget);
    expect(redirectToRegisterButton, findsOneWidget);
    expect(redirectToResetPasswordButton, findsOneWidget);
  });

  testWidgets('RegisterView widget test', (WidgetTester tester) async {
    final firstNameField = find.byKey(ValueKey('firstNameField'));
    final lastNameField = find.byKey(ValueKey('lastNameField'));
    final emailField = find.byKey(ValueKey('registerEmailField'));
    final passwordField = find.byKey(ValueKey('registerPasswordField'));

    await _buildRegisterView(tester);

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(firstNameField, findsOneWidget);
    expect(lastNameField, findsOneWidget);
    expect(redirectToLoginButton, findsOneWidget);
  });

  testWidgets('ResetPassword widget test', (WidgetTester tester) async {
    final emailField = find.byKey(ValueKey('emailField'));
    final completeButton = find.byKey(ValueKey('resetPasswordButton'));

    await _buildResetPasswordView(tester);

    expect(emailField, findsOneWidget);
    expect(completeButton, findsOneWidget);
    expect(redirectToLoginButton, findsOneWidget);
  });
}

