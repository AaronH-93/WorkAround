import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'help_view_model.dart';

class HelpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HelpViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          body: Text(
              model.title
          ),
        ),
        viewModelBuilder: () => HelpViewModel());
  }
}