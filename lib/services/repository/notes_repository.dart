import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_around/models/note.dart';
import 'package:work_around/util/functions.dart';
import 'package:async/async.dart';

import 'firestore_constants.dart';

class NotesRepository{
  final FirebaseFirestore _firestore;
  NotesRepository(this._firestore);

  Future<Result<Success>> addOrUpdateNote(String userId, String workoutId, String exerciseId, Note note) async =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection('$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection/$exerciseId/$notesCollection')
            .doc(note.noteId)
            .set(note.toJson());
        return Success();
      });

  Stream<List<Note>> getNotes(String userId, String workoutId, String exerciseId) {
    return _firestore
        .collection('$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection/$exerciseId/$notesCollection')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((document) => Note.fromJson(document.data()))
          .toList(),
    );
  }

  Future<Result<Success>> deleteNote(String userId, String workoutId, String exerciseId, String noteId) =>
      ResultExtended.fromFutureWithTimeout(() async {
        await _firestore
            .collection(
            '$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection/$exerciseId/$notesCollection')
            .doc(noteId)
            .delete();
        return Success();
      });

  Future<Note> getNote(String userId, String workoutId, String exerciseId, String noteId) async {
    final document = await _firestore.collection('$usersCollection/$userId/$workoutCollection/$workoutId/$exerciseCollection/$exerciseId/$notesCollection').doc(noteId).get();
    return Note.fromJson(document.data());
  }
}