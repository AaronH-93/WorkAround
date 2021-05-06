import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/user_exercise.dart';

class ExerciseInformationView extends StatelessWidget {
  final Exercise exercise;
  ExerciseInformationView({this.exercise});

  //This page will display all the information for an exercise, check musclewiki for ideas
  //Include how-to instructions, gif/videos from musclewiki?, description of exercise
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                //Style this.
                child: Text(
                    exercise.name,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: GifLoader(gifUrl: exercise.gifUrl),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Material(
                    borderRadius: buildBorderRadius(),
                    color: Colors.grey[300],
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Container(
                              child: Text(
                                'INSTRUCTIONS',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              exercise.instructions,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RoundedButton(
                title: 'Back',
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                    'Exercise Information Provided by MuscleWiki.'
                ),
                onPressed: (){
                  _directToMuscleWiki();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _directToMuscleWiki() async => await canLaunch('https://musclewiki.com/') ? await launch('https://musclewiki.com/') : throw 'Could not launch https://musclewiki.com/';

class GifLoader extends StatelessWidget {
  final String gifUrl;
  GifLoader({this.gifUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      gifUrl,
      fit: BoxFit.cover,
      loadingBuilder:
          (BuildContext context, Widget child, ImageChunkEvent progress) {
        if (progress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes
                : null,
          ),
        );
      },
    );
  }
}

BorderRadius buildBorderRadius() => BorderRadius.only(
    topRight: Radius.circular(10.0),
    topLeft: Radius.circular(10.0),
    bottomLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0));
