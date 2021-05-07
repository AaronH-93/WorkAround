import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'settings_view_model.dart';

//TODO: INCLUDE MUSCLEWIKI COPYRIGHT JAZZ

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          body: Text(
              model.title
          ),
        ),
        viewModelBuilder: () => SettingsViewModel()
    );
  }
}