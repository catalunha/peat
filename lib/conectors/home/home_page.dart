import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/home/home_page_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String id;
  String displayName;
  String email;
  ViewModel();
  ViewModel.build({
    @required this.id,
    @required this.displayName,
    @required this.email,
  }) : super(equals: [
          id,
          displayName,
          email,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        id: state.loggedState.firebaseUserLogged.uid,
        displayName: state.loggedState.userModelLogged?.displayName ?? '',
        email: state.loggedState.userModelLogged.email,
      );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => HomePageDS(
        id: viewModel.id,
        displayName: viewModel.displayName,
        email: viewModel.email,
      ),
    );
  }
}
