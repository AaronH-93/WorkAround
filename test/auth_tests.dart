import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/user_repository.dart';

class MockFirebaseUser extends Mock implements User {}

MockFirebaseUser mockUser = MockFirebaseUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([mockUser]);
  }
}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockAuthenticationService extends Mock implements AuthenticationService {}
class MockUserRepository extends Mock implements UserRepository {}
class MockFirestore extends Mock implements FirebaseFirestore {}
class MockNavigationService extends Mock implements NavigationService {}

void main() {
  final mockFirebaseAuth = MockFirebaseAuth();
  final mockUserRepo = MockUserRepository();
  final mockAuthService = MockAuthenticationService();
  final expected = Future.value('userId');
  final auth = AuthenticationService(mockFirebaseAuth, mockUserRepo);

  test('Emit occurs', () async {
    expectLater(auth.firebaseUser, emitsInOrder([mockUser]));
  });

  test('Login', () async {
    when(mockAuthService.signIn('email', 'password')).thenAnswer((_) => expected);
    final result = mockAuthService.signIn('email', 'password');
    expect(result, expected);
  });

  test('Register', () async {
    when(mockAuthService.register('unit', 'test', 'email', 'password')).thenAnswer((_) => expected);
    final result = mockAuthService.register('unit', 'test', 'email', 'password');
    expect(result, expected);
  });
}
