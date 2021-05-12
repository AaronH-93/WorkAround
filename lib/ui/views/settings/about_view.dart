import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about_view_model.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'WorkAround',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              Center(child: _WorkAroundText()),
              RoundedButton(
                title: 'Back',
                color: Colors.redAccent,
                onPressed: () {
                  model.navigateToHomeView();
                },
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AboutViewModel(
        Provider.of<NavigationService>(context, listen: false),
      ),
    );
  }
}

class _WorkAroundText extends StatelessWidget {
  const _WorkAroundText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'WorkAround is the dynamic workout application for those who want their workout session to revolve around them and not the other way around!',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              'Exercise information has been provided by MuscleWiki.com in accordance to their copyright, which states that the gifs and text can be used free of charge and without prior consent'
                  ' so long as the MuscleWiki branding is used, along with links back to the MuscleWiki website. This is provided in every Exercise\'s information page.',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          TextButton(
              onPressed: (){
                _directToMuscleWikiCopyright();
              },
              child: Text(
                'Link to MuscleWiki.com copyright information.'
              ),),
        ],
      ),
    );
  }
}

void _directToMuscleWikiCopyright() async => await canLaunch('https://musclewiki.com/Copyright') ? await launch('https://musclewiki.com/Copyright') : throw 'Could not launch https://musclewiki.com/Copyright';

