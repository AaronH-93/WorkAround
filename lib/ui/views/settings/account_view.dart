import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'account_view_model.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          body: Text(
              model.title
          ),
        ),
        viewModelBuilder: () => AccountViewModel());
  }
}