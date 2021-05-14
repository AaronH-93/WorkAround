import 'package:stacked/stacked.dart';
import 'package:work_around/models/note.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/notes_repository.dart';

class ViewNoteViewModel extends StreamViewModel<List<Note>>{
  final NavigationService _navigationService;
  final AuthenticationService _authenticationService;
  final ExerciseService _exerciseService;
  final NotesRepository _notesRepository;

  ViewNoteViewModel(this._navigationService, this._notesRepository, this._authenticationService, this._exerciseService);

  void pop() => _navigationService.pop();

  String get exerciseId => _exerciseService.getExerciseIdForNotes;

  @override
  Stream<List<Note>> get stream => _notesRepository.getNotes(_authenticationService.currentId, _exerciseService.currentWorkoutId, _exerciseService.getExerciseIdForNotes);
  List<Note> get notes => data;

  void updateOrAddNote(Note note) => _notesRepository.addOrUpdateNote(_authenticationService.currentId, _exerciseService.currentWorkoutId, _exerciseService.getExerciseIdForNotes, note);
  void deleteNote(String noteId) => _notesRepository.deleteNote(_authenticationService.currentId, _exerciseService.currentWorkoutId, _exerciseService.getExerciseIdForNotes, noteId);
}