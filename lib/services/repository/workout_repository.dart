import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/util/functions.dart';
import 'firestore_constants.dart';

class WorkoutRepository {
  final FirebaseFirestore _firestore;
  WorkoutRepository(this._firestore);

  Future<Result<Success>> addOrUpdateWorkout(String userId, UserWorkout workout) async =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection('$usersCollection/$userId/$workoutCollection')
            .doc(workout.workoutId)
            .set(workout.toJson());
        return Success();
      });

  Stream<List<UserWorkout>> getWorkouts(String userId) {
    return _firestore
        .collection('$usersCollection/$userId/$workoutCollection')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((document) => UserWorkout.fromJson(document.data()))
              .toList(),
        );
  }

  Future<Result<Success>> deleteWorkout(String userId, String workoutId) =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection(
            "$usersCollection/$userId/$workoutCollection/")
            .doc(workoutId)
            .delete();
        return Success();
      });

  Future<UserWorkout> getWorkout(String userId, String workoutId) async {
    final document = await _firestore.collection('$usersCollection/$userId/$workoutCollection').doc(workoutId).get();
    return UserWorkout.fromJson(document.data());
  }
}
