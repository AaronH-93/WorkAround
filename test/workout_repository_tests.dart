import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:work_around/services/repository/workout_repository.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference{}

class MockDocumentReference extends Mock implements DocumentReference{}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot{}

class MockQuerySnapshot extends Mock implements QuerySnapshot{}

class MockWorkoutRepository extends Mock implements WorkoutRepository{}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot{}

void main() {
  MockFirestore instance;
  MockDocumentSnapshot mockDocumentSnapshot;
  MockCollectionReference mockCollectionReference;
  MockDocumentReference mockDocumentReference;
  MockQuerySnapshot mockQuerySnapshot;
  MockWorkoutRepository mockWorkoutRepository;
  MockQueryDocumentSnapshot mockQueryDocumentSnapshot;

  final Map<String, dynamic> responseMap = {
    'name' : 'Workout 1',
    'workoutId' : 'abcd1234',
  };

  setUp(() {
    instance = MockFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
    mockQuerySnapshot = MockQuerySnapshot();
    mockWorkoutRepository = MockWorkoutRepository();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
  });
}
