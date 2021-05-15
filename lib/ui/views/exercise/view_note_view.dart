import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/note.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/notes_repository.dart';
import 'package:work_around/ui/views/exercise/view_note_view_model.dart';

class ViewNoteView extends StatefulWidget {
  final String exerciseName;

  ViewNoteView({this.exerciseName});

  @override
  _ViewNoteViewState createState() => _ViewNoteViewState();
}

class _ViewNoteViewState extends State<ViewNoteView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewNoteViewModel>.reactive(
      key: Key('viewNoteView'),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${widget.exerciseName} Notes',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              NotesList(),
              RoundedButton(
                widgetKey: Key('addNoteButton'),
                title: 'Add Note',
                color: Colors.redAccent,
                onPressed: () {
                  _createNoteDialog(context);
                },
              ),
              RoundedButton(
                widgetKey: Key('backButton'),
                title: 'Back',
                color: Colors.redAccent,
                onPressed: () {
                  model.pop();
                },
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ViewNoteViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<NotesRepository>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
      ),
    );
  }

  _createNoteDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (_) => _CreateNoteDialogBox(context: context),
    );
  }
}

class NotesList extends ViewModelWidget<ViewNoteViewModel> {
  @override
  Widget build(BuildContext context, ViewNoteViewModel model) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[300],
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              return model.dataReady
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[400],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${model.notes[index].noteText}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_sharp),
                                color: Colors.redAccent,
                                onPressed: () {
                                  model.deleteNote(model.notes[index].noteId);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox();
            },
            itemCount: model.dataReady ? model.notes.length : 1,
          ),
        ),
      ),
    );
  }
}

class _CreateNoteDialogBox extends StatelessWidget {
  final BuildContext context;
  final controller = TextEditingController();

  _CreateNoteDialogBox({this.context});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewNoteViewModel>.reactive(
      key: Key('createNoteDialogBox'),
      builder: (context, model, child) => AlertDialog(
        contentPadding: EdgeInsets.all(16.0),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                key: Key('createNoteDialogBox'),
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(labelText: 'Enter Note'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          _CreateNoteDialogButton(
            widgetKey: Key('cancelCreateNoteButton'),
            text: 'Cancel',
            onPressed: () {
              model.pop();
            },
          ),
          _CreateNoteDialogButton(
            widgetKey: Key('confirmCreateNoteButton'),
            text: 'Confirm',
            onPressed: () {
              String noteText = controller.text.isEmpty ? 'Empty note.' : controller.text;
              Note newNote = Note(Uuid().v4(), model.exerciseId, noteText);
              model.updateOrAddNote(newNote);
              model.pop();
            },
          ),
        ],
      ),
      viewModelBuilder: () => ViewNoteViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<NotesRepository>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
      ),
    );
  }
}

class _CreateNoteDialogButton extends StatelessWidget {
  final Key widgetKey;
  final String text;
  final Function onPressed;

  _CreateNoteDialogButton({this.text, this.onPressed, this.widgetKey});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widgetKey,
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
