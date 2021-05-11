import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:work_around/models/user.dart' as workAroundUser;
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/repository/user_repository.dart';

class MockFirebaseUser extends Mock implements User {}

MockFirebaseUser mockUser = MockFirebaseUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([mockUser]);
  }
}
class MockFirebaseUserCredentials extends Mock implements UserCredential {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockUserRepository extends Mock implements UserRepository {}
class MockFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference{}
class MockDocumentReference extends Mock implements DocumentReference{}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot{}
class MockQuerySnapshot extends Mock implements QuerySnapshot{}
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot{}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final MockUserRepository mockUserRepository = MockUserRepository();
  final AuthenticationService auth = AuthenticationService(mockFirebaseAuth, mockUserRepository);
  final Future<MockFirebaseUserCredentials> userCredentials = Future.value(MockFirebaseUserCredentials());
  MockFirestore firestore;
  MockDocumentSnapshot mockDocumentSnapshot;
  MockCollectionReference mockCollectionReference;
  MockDocumentReference mockDocumentReference;
  MockQuerySnapshot mockQuerySnapshot;
  MockQueryDocumentSnapshot mockQueryDocumentSnapshot;

  final Map<String, dynamic> expected = {
    'firstName' : 'Aaron',
    'lastName' : 'H',
    'email' : 'aaron@gmail.com',
  };

  final expectedUser = workAroundUser.User.fromJson(expected);

  setUp(() {
    firestore = MockFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
  });

  tearDown() {}

  test('Emit occurs', () async {
    expectLater(auth.firebaseUser, emitsInOrder([mockUser]));
  });
}
