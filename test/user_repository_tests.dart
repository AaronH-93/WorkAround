import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:work_around/models/user.dart';
import 'package:work_around/services/repository/user_repository.dart';
import 'package:work_around/util/functions.dart';

class MockFirestore extends Mock implements FirebaseFirestore{}
class MockCollectionReference extends Mock implements CollectionReference{}
class MockDocumentReference extends Mock implements DocumentReference{}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot{}

void main(){
  final mockFirestore = MockFirestore();
  final mockCollectionReference = MockCollectionReference();
  final mockDocumentReference = MockDocumentReference();
  final mockDocumentSnapshot = MockDocumentSnapshot();
  final userRepository = UserRepository(mockFirestore);

  final response = {
    'firstName' : 'A',
    'lastName' : 'H',
    'email' : 'test@test.com',
  };

  final expectedUser = User.fromJson(response);
  final success = Success();

  test('getUser returns user', () async {
    when(mockFirestore.collection('users')).thenAnswer((_) => mockCollectionReference);
    when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
    when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
    when(mockDocumentSnapshot.data()).thenReturn(response);

    final result = await userRepository.getUser('user_id');
    expect(expectedUser.firstName, result.firstName);
    expect(expectedUser.lastName, result.lastName);
    expect(expectedUser.email, result.email);
  });

  test('addOrUpdateUsers returns success', () async {
    when(mockFirestore.collection('users')).thenAnswer((_) => mockCollectionReference);
    when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
    when(mockDocumentReference.set(expectedUser.toJson())).thenAnswer((_) async => success);

    final result = await userRepository.addOrUpdateUser('uid', expectedUser);
    expect(result.isError, false);
  });
}