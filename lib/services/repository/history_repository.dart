import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/util/functions.dart';
import 'firestore_constants.dart';

class HistoryRepository {
  final FirebaseFirestore _firestore;
  HistoryRepository(this._firestore);

  Future<Result<Success>> addOrUpdateWorkout(String userId, UserWorkout workout) async =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection('$usersCollection/$userId/$workoutHistoryCollection')
            .doc(workout.workoutId)
            .set(workout.toJson());
        return Success();
      });

  Future<Result<Success>> addOrUpdateExercise(String userId, String workoutId, UserExercise exercise) async =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection('$usersCollection/$userId/$workoutHistoryCollection/$workoutId/$exerciseCollection')
            .doc(exercise.exerciseId)
            .set(exercise.toJson());
        return Success();
      });

  Future<Result<Success>> addOrUpdateExerciseSets(String userId, String workoutId, UserSet set) async =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection('$usersCollection/$userId/$workoutHistoryCollection/$workoutId/$exerciseCollection/${set.exerciseId}/$setsCollection/')
            .doc(set.setId)
            .set(set.toJson());
        return Success();
      });

  Stream<List<UserWorkout>> getWorkouts(String userId) {
    return _firestore
        .collection('$usersCollection/$userId/$workoutHistoryCollection')
        .orderBy('date')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((document) => UserWorkout.fromJson(document.data()))
          .toList(),
    );
  }

  Stream<List<UserExercise>> getExercises(String userId, String workoutId) {
    return _firestore
        .collection(
        '$usersCollection/$userId/$workoutHistoryCollection/$workoutId/$exerciseCollection')
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs
              .map((document) => UserExercise.fromJson(document.data()))
              .toList(),
    );
  }

  Stream<List<UserSet>> getExerciseSets(String userId, String workoutId, String exerciseId) {
    return _firestore
        .collection(
        '$usersCollection/$userId/$workoutHistoryCollection/$workoutId/$exerciseCollection/$exerciseId/$setsCollection')
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs
              .map((document) => UserSet.fromJson(document.data()))
              .toList(),
    );
  }
}