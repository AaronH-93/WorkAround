import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/util/functions.dart';
import 'firestore_constants.dart';

class ExerciseRepository {
  final FirebaseFirestore _firestore;

  ExerciseRepository(this._firestore);

  Future<Result<Success>> addOrUpdateExercise(String userId, String workoutId, UserExercise exercise) async =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection('$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection')
            .doc(exercise.exerciseId)
            .set(exercise.toJson());
        return Success();
      });

  Stream<List<UserExercise>> getExercises(String userId, String workoutId) {
    return _firestore
        .collection(
        '$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection')
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs
              .map((document) => UserExercise.fromJson(document.data()))
              .toList(),
    );
  }

  Stream<List<UserSet>> getExerciseSets(String userId, String workoutId,
      String exerciseId) {
    return _firestore
        .collection(
        '$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection/$exerciseId/$setsCollection')
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs
              .map((document) => UserSet.fromJson(document.data()))
              .toList(),
    );
  }

  Future<Result<Success>> deleteSet(String userId, String workoutId,
      String exerciseId, String setId) =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection(
            '$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection/$exerciseId/$setsCollection')
            .doc(setId)
            .delete();
        return Success();
      });

  Future<Result<Success>> updateSet(String userId, String workoutId, UserSet set) => ResultExtended.fromFutureWithTimeout(() async {
    await _firestore
        .collection(
        '$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection/${set.exerciseId}/$setsCollection/')
        .doc(set.setId)
        .set(set.toJson());
    return Success();
  });

  Future<Result<Success>> addOrUpdateExerciseSets(String userId, String workoutId, UserSet set) async =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection('$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection/${set.exerciseId}/$setsCollection/')
            .doc(set.setId)
            .set(set.toJson());
        return Success();
      });

  Future<Result<Success>> clearSets(String currentId, String getWorkoutIdToEdit, String getWorkoutIdToEdit2) async =>
      ResultExtended.fromFutureWithTimeout(() async  {
        await _firestore
            .collection('$usersCollection/$currentId/$workoutCollection/$getWorkoutIdToEdit/$exerciseCollection/$getWorkoutIdToEdit2/$setsCollection/')
            .get()
            .then((snapshot) {
              for(DocumentSnapshot doc in snapshot.docs){
                doc.reference.delete();
              }
            });
        return Success();
      });

  Future<Result<Success>> deleteExercise(String userId, String workoutId,
      String exerciseId) =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection(
            '$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection/')
            .doc(exerciseId)
            .delete();
        return Success();
      });
}