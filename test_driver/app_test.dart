import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//The command to run the integration tests in the terminal is:
// flutter drive --target=test_driver/app.dart

//For integration test to work, registration email must be changed before every test
//as the integration test checks against a function application and database. If it tries
//to register an account with a duplicate email, the integration test will fail.

void main() {
  FlutterDriver driver;
  final String registrationEmail = 'test01@test.com';

  group('WorkAround App', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
        driver.close();
    });

    test('Navigate to Register View', () async{
      await driver.tap(find.byValueKey('registerButton'));
      await driver.waitFor(find.byValueKey('registerView'), timeout: Duration(seconds: 3));
    });

    test('Navigate to Login View', () async{
      await driver.tap(find.byValueKey('redirectToLoginButton'));
      await driver.waitFor(find.byValueKey('loginView'), timeout: Duration(seconds: 3));
    });

    test('Navigate to ResetPassword View', () async {
      await driver.tap(find.byValueKey('redirectToResetPasswordButton'));
      await driver.waitFor(find.byValueKey('resetPasswordView'), timeout: Duration(seconds: 3));
    });

    test('Navigate back to Register View', () async {
      await driver.tap(find.byValueKey('redirectToRegisterButton'));
      await driver.waitFor(find.byValueKey('registerView'), timeout: Duration(seconds: 3));
    });

    test('Register', () async{
      await driver.tap(find.byValueKey('firstNameField'));
      await driver.enterText('Integration');
      await driver.tap(find.byValueKey('lastNameField'));
      await driver.enterText('Test');
      await driver.tap(find.byValueKey('registerEmailField'));
      await driver.enterText(registrationEmail);
      await driver.tap(find.byValueKey('registerPasswordField'));
      await driver.enterText('abcd1234');
      await driver.tap(find.byValueKey('submitRegisterButton'));
      await driver.waitFor(find.byValueKey('homeView'), timeout: Duration(seconds: 3));
    });

    test('dismiss create workout dialog', () async {
      await driver.tap(find.byValueKey('createWorkoutButton'));
      await driver.waitFor(find.byValueKey('createWorkoutDialogBox'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('cancelCreateWorkoutButton'));
    });

    test('Cancel workout creation', () async {
      await driver.tap(find.byValueKey('createWorkoutButton'));
      await driver.waitFor(find.byValueKey('createWorkoutDialogBox'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('createWorkoutDialogBox'));
      await driver.enterText('Workout 1');
      await driver.tap(find.byValueKey('confirmCreateWorkoutButton'));
      await driver.waitFor(find.byValueKey('createWorkoutView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('cancelWorkoutCreation'));
      await driver.waitFor(find.byValueKey('homeView'), timeout: Duration(seconds: 3));
    });

    test('Create a workout', () async {
      await driver.tap(find.byValueKey('createWorkoutButton'));
      await driver.waitFor(find.byValueKey('createWorkoutDialogBox'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('createWorkoutDialogBox'));
      await driver.enterText('Workout 1');
      await driver.tap(find.byValueKey('confirmCreateWorkoutButton'));
      await driver.waitFor(find.byValueKey('createWorkoutView'), timeout: Duration(seconds: 3));
      //first exercise
      await driver.tap(find.byValueKey('addExerciseButton'));
      await driver.waitFor(find.byValueKey('exercisesView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('Bicep Curl'));
      await driver.waitFor(find.byValueKey('addExerciseView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('setsField'));
      await driver.enterText('3');
      await driver.tap(find.byValueKey('repsField'));
      await driver.enterText('10');
      await driver.tap(find.byValueKey('submitExerciseButton'));
      await driver.waitFor(find.byValueKey('createWorkoutView'), timeout: Duration(seconds: 3));
      //second exercise
      await driver.tap(find.byValueKey('addExerciseButton'));
      await driver.waitFor(find.byValueKey('exercisesView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('Hammer Curl'));
      await driver.waitFor(find.byValueKey('addExerciseView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('setsField'));
      await driver.enterText('3');
      await driver.tap(find.byValueKey('repsField'));
      await driver.enterText('10');
      await driver.tap(find.byValueKey('submitExerciseButton'));
      await driver.waitFor(find.byValueKey('createWorkoutView'), timeout: Duration(seconds: 3));
      //third exercise
      await driver.tap(find.byValueKey('addExerciseButton'));
      await driver.waitFor(find.byValueKey('exercisesView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('Barbell Curl'));
      await driver.waitFor(find.byValueKey('addExerciseView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('setsField'));
      await driver.enterText('3');
      await driver.tap(find.byValueKey('repsField'));
      await driver.enterText('10');
      await driver.tap(find.byValueKey('submitExerciseButton'));
      await driver.waitFor(find.byValueKey('createWorkoutView'), timeout: Duration(seconds: 3));
      //create the workout
      await driver.tap(find.byValueKey('finishWorkoutCreation'));
      await driver.waitFor(find.byValueKey('homeView'), timeout: Duration(seconds: 3));
    });

    test('edit a workout -> edit exercise', () async {
      await driver.tap(find.byValueKey('Workout 1_editWorkoutButton'));
      await driver.waitFor(find.byValueKey('editWorkoutView'));
      await driver.tap(find.byValueKey('Bicep Curl_editExerciseButton'));
      //Edit existing exercise
      await driver.waitFor(find.byValueKey('editExerciseView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('editSetsField'));
      await driver.enterText('3');
      await driver.tap(find.byValueKey('editRepsField'));
      await driver.enterText('20');
      await driver.tap(find.byValueKey('completeEditButton'));
      await driver.waitFor(find.byValueKey('editWorkoutView'), timeout: Duration(seconds: 3));
    });

    test('edit a workout -> add exercise', () async {
      await driver.tap(find.byValueKey('addExerciseButton'));
      await driver.waitFor(find.byValueKey('exercisesView'), timeout: Duration(seconds: 3));
      //Add new exercise
      await driver.tap(find.byValueKey('Preacher Curl'));
      await driver.waitFor(find.byValueKey('addExerciseView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('setsField'));
      await driver.enterText('3');
      await driver.tap(find.byValueKey('repsField'));
      await driver.enterText('10');
      await driver.tap(find.byValueKey('submitExerciseButton'));
      await driver.waitFor(find.byValueKey('editWorkoutView'), timeout: Duration(seconds: 3));
    });

    test('edit a workout -> delete exercise', () async{
      await driver.tap(find.byValueKey('Hammer Curl_deleteExerciseButton'));
    });

    test('edit a workout -> complete edit', () async{
      await driver.tap(find.byValueKey('finishEditExerciseButton'));
      await driver.waitFor(find.byValueKey('homeView'), timeout: Duration(seconds: 3));
    });

    test('perform workout and add note', () async {
      await driver.tap(find.byValueKey('Workout 1_startWorkoutButton'));
      await driver.waitFor(find.byValueKey('workoutDurationField'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('workoutDurationField'));
      await driver.enterText('7');
      await driver.tap(find.byValueKey('beginWorkoutButton'));
      await driver.waitFor(find.byValueKey('workoutView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('Preacher Curl_notesViewButton'));
      await driver.waitFor(find.byValueKey('viewNoteView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('addNoteButton'));
      await driver.waitFor(find.byValueKey('createNoteDialogBox'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('createNoteText'));
      await driver.enterText('Keep form!');
      await driver.tap(find.byValueKey('confirmCreateNoteButton'));
      await driver.tap(find.byValueKey('backButton'));
      await driver.waitFor(find.byValueKey('workoutView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('finishWorkoutButton'));
      await driver.waitFor(find.byValueKey('homeView'), timeout: Duration(seconds: 3));
    });

    test('view workout history', () async {
      await driver.tap(find.byValueKey('historyButton'));
      await driver.waitFor(find.byValueKey('historyView'), timeout: Duration(seconds: 3));
    });

    test('view workout history -> view workout -> home view', () async {
      await driver.tap(find.byValueKey('Workout 1_viewHistoryButton'));
      await driver.waitFor(find.byValueKey('exerciseHistoryView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('exerciseHistoryBackButton'));
      await driver.waitFor(find.byValueKey('historyView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('backButton'));
      await driver.waitFor(find.byValueKey('homeView'), timeout: Duration(seconds: 3));
    });

    test('view exercise catalogue', () async {
      await driver.tap(find.byValueKey('exercisesButton'));
      await driver.waitFor(find.byValueKey('viewExercisesView'), timeout: Duration(seconds: 3));
    });

    test('view exercise catalogue -> search exercises -> view exercise information', () async {
      await driver.tap(find.byValueKey('searchField'));
      await driver.enterText('abdominals');
      await driver.enterText('hamstrings');
      await driver.enterText('bicep');
      await driver.tap(find.byValueKey('Bicep Curl_viewButton'));
      await driver.waitFor(find.byValueKey('exerciseInformationView'), timeout: Duration(seconds: 3));
      await driver.waitFor(find.byValueKey('gif'));
      await driver.tap(find.byValueKey('backButton'));
      await driver.waitFor(find.byValueKey('viewExercisesView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('backButton'));
      await driver.waitFor(find.byValueKey('homeView'), timeout: Duration(seconds: 3));
    });

    test('sign out', () async {
      await driver.tap(find.byValueKey('signOut'));
      await driver.waitFor(find.byValueKey('welcomeView'), timeout: Duration(seconds: 3));
    });

    test('Login', () async{
      await driver.tap(find.byValueKey('loginButton'));
      await driver.waitFor(find.byValueKey('loginView'), timeout: Duration(seconds: 3));
      await driver.tap(find.byValueKey('emailField'));
      await driver.enterText(registrationEmail);
      await driver.tap(find.byValueKey('passwordField'));
      await driver.enterText('abcd1234');
      await driver.tap(find.byValueKey('submit'));
      await driver.waitFor(find.byValueKey('homeView'), timeout: Duration(seconds: 3));
    });
  });
}
