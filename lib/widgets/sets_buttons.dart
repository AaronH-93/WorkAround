import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/set_button.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/widgets/sets_buttons_view_model.dart';

class SetsButtons extends StatefulWidget {
  @override
  _SetsButtonsState createState() => _SetsButtonsState();
}

class _SetsButtonsState extends State<SetsButtons> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetsButtonsViewModel>.reactive(
      builder: (context, model, child) => model.dataReady
          ? buildRowOfButtons(model)
          : Container(child: Text('Loading sets')),
      viewModelBuilder: () => SetsButtonsViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
      ),
    );
  }

  Widget buildRowOfButtons(SetsButtonsViewModel model) {
    List<Widget> list = [];
    List<UserSet> setList = model.userSets;
    for (UserSet set in setList) {
      model.addToSetHistory(set);
      if (model.isSetWithinDuration(set)) {
        list.add(
          SetButton(set: set),
        );
      }
    }
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list,
    );
  }
}
