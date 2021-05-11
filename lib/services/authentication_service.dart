import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:work_around/models/user.dart';
import 'package:work_around/services/repository/user_repository.dart';

typedef firebaseAuthFunction<P> = Future<P> Function();

class AuthenticationService{
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;
  auth.User _currentUser;

  AuthenticationService(this._firebaseAuth, this._userRepository);

  Stream<auth.User> get firebaseUser => _firebaseAuth.authStateChanges();

  Future<String> register(String firstName, String lastName, String email,
      String password) async =>
      _translatePlatformException(() async {
        final result = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        final user = User(firstName, lastName, email);
        await _userRepository.addOrUpdateUser(result.user.uid, user);

        _currentUser = result.user;
        return result.user.uid;
      });

  Future<String> signIn(String email, String password) async =>
      _translatePlatformException(() async {
        final result = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        _currentUser = result.user;
        return result.user.uid;
      });

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> isUserLoggedIn() async {
    final auth.User user = _firebaseAuth.currentUser;
    _currentUser = user;
    return user?.uid != null;
  }

  Future<void> passwordReset(String email) async =>
      _translatePlatformException(() async {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      });

  String get currentEmail => _currentUser.email;

  String get currentId => _currentUser.uid;



  Future<T> _translatePlatformException<T>(
      firebaseAuthFunction<T> authFunction) async {
    try {
      return await authFunction();
    } on PlatformException catch (exception) {
      throw AuthenticationServiceException(
          _translatePlatformExceptionCode(exception));
    }
  }
}

String _translatePlatformExceptionCode(PlatformException exception) {
  switch (exception.code) {
    case "ERROR_INVALID_EMAIL":
      return "Your email address appears to be malformed.";
    case "ERROR_WRONG_PASSWORD":
      return "Password is incorrect.";
    case "ERROR_USER_NOT_FOUND":
      return "User with this email does not exist.";
    case "ERROR_USER_DISABLED":
      return "User with this email has been disabled.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many requests. Please try again later.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Signing in with Email and Password is not enabled.";
    case "ERROR_WEAK_PASSWORD":
      return "Password is not strong enough";
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email address is already in use";
    case "ERROR_NETWORK_REQUEST_FAILED":
      return "Please check your internet connection and try again.";
    default:
      return "An undefined Error happened.";
  }
}

class AuthenticationServiceException implements Exception {
  String message;
  AuthenticationServiceException(this.message);
}
