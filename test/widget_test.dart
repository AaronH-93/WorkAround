// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are corr
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/ui/views/auth/login_view.dart';
import 'package:work_around/ui/views/home/welcome_view.dart';
import 'package:work_around/ui/views/home/welcome_view_model.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockWelcomeViewModel extends Mock implements WelcomeViewModel {}

class MockNavigationService extends Mock implements NavigationService {}

class MockAuthenticationService extends Mock implements AuthenticationService {}

void main() {
  final mockNavigationService = MockNavigationService();
  final mockAuth = MockAuthenticationService();

  final mockObserver = MockNavigatorObserver();
  final mockViewModel = MockWelcomeViewModel();

  Widget _createTestWidget({Widget view}) {
    return ViewModelBuilder<MockWelcomeViewModel>.reactive(
      builder: (context, model, child) => MaterialApp(
        home: view,
        navigatorObservers: [mockObserver],
      ),
      viewModelBuilder: () => MockWelcomeViewModel(
      ),
    );
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
            builder: (_) => _createTestWidget(view: LoginView())
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
            builder: (_) => _createTestWidget(view: WelcomeView())
        ),
      ),
    );
    verify(mockObserver.didPush(any, any));
  }

  Future<Null> _navigateToLoginView(WidgetTester tester) async {
    final finder = find.byKey(ValueKey('loginButton'));
    expect(finder, findsOneWidget);

    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
