import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'exercise_tile_view_model.dart';
import 'sets_buttons.dart';

class ExerciseTile extends StatefulWidget {
  final UserExercise exercise;
  ExerciseTile({this.exercise});
  @override
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {

  @override
  void initState() {
    super.initState();
    Provider.of<ExerciseService>(context, listen: false).setCurrentExerciseId(widget.exercise.exerciseId);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExerciseTileViewModel>.reactive(
      viewModelBuilder: () => ExerciseTileViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
      ),
      builder: (context, model, child) => Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 5,
            borderRadius: buildBorderRadiusTop(),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.info_sharp),
                      color: Colors.redAccent,
                      onPressed: () {
                        _showExerciseInstructions(widget.exercise.instructions, widget.exercise.gifUrl);
                      },
                    ),
                    ExerciseContainer(
                      text: widget.exercise.name,
                    ),
                    IconButton(
                      key: Key('${widget.exercise.name}_notesViewButton'),
                      icon: Icon(Icons.notes_sharp),
                      color: Colors.redAccent,
                      onPressed: () {
                        model.setExerciseIdForNotes(widget.exercise.exerciseId);
                        model.navigateToViewNotesView(widget.exercise.name);
                        },
                    ),
                  ],
                ),
                ExerciseContainer(
                  text: '${widget.exercise.reps} reps per set at ${widget.exercise.weight == null ? 'undefined weight.' : '${widget.exercise.weight} KG'}',
                ),
              ],
            ),
          ),
          Material(
            borderRadius: buildBorderRadiusBottom(),
            elevation: 5,
            color: Colors.red[300],
            child: SetsButtons(),
          ),
        ],
      ),
    );
  }

  _showExerciseInstructions(String instructions, String gifUrl) async {
    await showDialog<String>(
      context: context,
      builder: (_) => _InstructionsDialogBox(
        context: context,
        instructions: instructions,
        gifUrl: gifUrl,
      ),
    );
  }
}

class _InstructionsDialogBox extends StatelessWidget {
  final BuildContext context;
  final String instructions;
  final String gifUrl;

  _InstructionsDialogBox({this.context, this.instructions, this.gifUrl});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GifLoader(gifUrl: gifUrl),
          Material(
            borderRadius: buildBorderRadiusBottom(),
            color: Colors.grey[300],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    instructions,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    child: Text(
                        'Exercise Information Provided by MuscleWiki.'
                    ),
                    onPressed: (){
                      _directToMuscleWiki();
                    },
                  ),
                ),
                TextButton(
                  key: Key('instructionsDialogBoxButton'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void _directToMuscleWiki() async => await canLaunch('https://musclewiki.com/') ? await launch('https://musclewiki.com/') : throw 'Could not launch https://musclewiki.com/';

class ExerciseContainer extends StatelessWidget {
  final String text;

  ExerciseContainer({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TileText(text: text),
        ],
      ),
    );
  }
}

class TileText extends StatelessWidget {
  final String text;

  TileText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}

class GifLoader extends StatelessWidget {
  final String gifUrl;
  GifLoader({this.gifUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      gifUrl,
      key: Key('gif'),
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent progress) {
        if (progress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes : null,
          ),
        );
      },
    );
  }
}

BorderRadius buildBorderRadiusTop() => BorderRadius.only(
    topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0));

BorderRadius buildBorderRadiusBottom() => BorderRadius.only(
    bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0));
