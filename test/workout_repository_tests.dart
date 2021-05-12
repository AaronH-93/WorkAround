import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/repository/workout_repository.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference{}

class MockDocumentReference extends Mock implements DocumentReference{}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot{}

class MockQuerySnapshot extends Mock implements QuerySnapshot{}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot{}

void main() {
  final mockFirestore = MockFirestore();
  final mockDocumentSnapshot = MockDocumentSnapshot();
  final mockCollectionReference = MockCollectionReference();
  final mockDocumentReference = MockDocumentReference();
  final workoutRepository = WorkoutRepository(mockFirestore);


  final Map<String, dynamic> response = {
    'name' : 'Workout 1',
    'workoutId' : 'abcd1234',
  };

  final Map<String, dynamic> responseTwo = {
    'name' : 'Workout 2',
    'workoutId' : 'efgh5678',
  };

  final expectedWorkout = UserWorkout.fromJson(response);
  final expectedWorkoutTwo = UserWorkout.fromJson(responseTwo);

  final List<UserWorkout> workoutList = [
    expectedWorkout,
    expectedWorkoutTwo,
  ];

  test('getWorkout returns workout', () async {
    when(mockFirestore.collection(any)).thenAnswer((_) => mockCollectionReference);
    when(mockCollectionReference.doc('workout_id')).thenReturn(mockDocumentReference);
    when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
    when(mockDocumentSnapshot.data()).thenReturn(response);

    final result = await workoutRepository.getWorkout('user_id', 'workout_id');
    expect(result.name, expectedWorkout.name);
    expect(result.workoutId, expectedWorkout.workoutId);
  });
}
