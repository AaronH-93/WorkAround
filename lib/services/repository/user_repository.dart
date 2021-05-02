import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_around/util/functions.dart';
import 'package:work_around/models/user.dart';
import 'firestore_constants.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository(this._firestore);

  Future<Result<Success>> addOrUpdateUser(String uid, User user) async =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection(usersCollection)
            .doc(uid)
            .set(user.toJson());
        return Success();
      });

  Future<User> getUser(String userId) async {
    final document = await _firestore.collection(usersCollection).doc(userId).get();
    return User.fromJson(document.data());
  }
}

